//
//  XMPPManager.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMPPManager.h"
typedef NS_ENUM(NSInteger, ConnectServerPurpose)
{
    ConnectServerPurposeLogin,    //登录
    ConnectServerPurposeRegister   //注册
};

@interface XMPPManager ()
@property(nonatomic)ConnectServerPurpose connectServerPurposeType;//用来标记连接服务器目的的属性
@end


@implementation XMPPManager


static XMPPManager *_instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XMPPManager alloc] init];
        [_instance setupStream];
    });
    
    return _instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

#pragma mark -- strean setup

- (void)setupStream
{
    if (!_xmppStream) {
        _xmppStream = [[XMPPStream alloc] init];
        
        [self.xmppStream setHostName:XMPP_HOST];
        [self.xmppStream setHostPort:XMPP_PORT];
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [self.xmppStream setKeepAliveInterval:30];
        self.xmppStream.enableBackgroundingOnSocket=YES;
        
        //接入断线重连模块
        _xmppReconnect = [[XMPPReconnect alloc] init];
        [_xmppReconnect setAutoReconnect:YES];
        [_xmppReconnect activate:self.xmppStream];
        
        //接入流管理模块
        _storage = [XMPPStreamManagementMemoryStorage new];
        _xmppStreamManagement = [[XMPPStreamManagement alloc] initWithStorage:_storage];
        _xmppStreamManagement.autoResume = YES;
        [_xmppStreamManagement addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_xmppStreamManagement activate:self.xmppStream];
        
        //接入好友模块
        _xmppRosterMemoryStorage = [[XMPPRosterMemoryStorage alloc] init]; //获得一个存储好友的CoreData库，用来数据持久化
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterMemoryStorage]; //初始化xmppRoster
        [_xmppRoster activate:self.xmppStream]; //激活
        [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()]; //设置代理
        
        //接入消息模块
        _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        _xmppMessageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 9)];
        [_xmppMessageArchiving activate:self.xmppStream];

    }
}


#pragma mark -- go onlie, offline

-(void)loginWithName:(NSString *)userName andPassword:(NSString *)password
{
    _myJID = [XMPPJID jidWithUser:userName domain:XMPP_DOMAIN resource:@"iOS"];
    self.myPassword = password;
     self.connectServerPurposeType = ConnectServerPurposeLogin;
    [self.xmppStream setMyJID:_myJID];

    if ([self.xmppStream isConnected]) {
        [self logOut];
    }

    [self connectToServer];
    }
#pragma mark xmppStream的代理方法



-(void)registerWithName:(NSString *)userName andPassword:(NSString *)password{
    self.myPassword = password;
    //0.标记连接服务器的目的
    self.connectServerPurposeType = ConnectServerPurposeRegister;
    //1. 创建一个jid
    XMPPJID *jid = [XMPPJID jidWithUser:userName domain:XMPP_DOMAIN
                               resource:@"iOS"];
    //2.将jid绑定到xmppStream
    self.xmppStream.myJID = jid;
    //3.连接到服务器
    [self connectToServer];
    
}
#pragma mark 注册成功的方法
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功的方法");
        
}
#pragma mark 注册失败的方法
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"注册失败执行的方法");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册失败"
                                                        message:@"很遗憾您注册失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:nil];
    [alertView show];

}
-(void)connectToServer{
    //如果已经存在一个连接，需要将当前的连接断开，然后再开始新的连接
    if ([self.xmppStream isConnected]) {
        [self logOut];
    }
    NSError *error = nil;
    [self.xmppStream connectWithTimeout:30.0f error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
}

-(void)logOut
{
    [self goOffline];
    [_xmppStream disconnectAfterSending];
}


- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    [[self xmppStream] sendElement:presence];
}

- (void)sendMessage:(NSString *)message to:(XMPPJID *)jid
{
    XMPPMessage* newMessage = [[XMPPMessage alloc] initWithType:@"chat" to:jid];
    [newMessage addBody:message];
    [_xmppStream sendElement:newMessage];
}


#pragma mark -- connect delegate

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    NSLog(@"%s",__func__);
}


-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接服务器成功的方法");
    //登录
    if (self.connectServerPurposeType == ConnectServerPurposeLogin) {
        NSError *error = nil;
        //        向服务器发送密码验证 //验证可能失败或者成功
        [sender authenticateWithPassword:self.myPassword error:&error];
        //        NSLog(@"-----%@",self.password);
    }
    //注册
    else{
        //向服务器发送一个密码注册（成功或者失败）
        [sender registerWithPassword:self.myPassword error:nil];
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"%s",__func__);
    NSLog(@"连接服务器失败的方法，请检查网络是否正常");

}
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
                                                        message:@"connect fail"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    NSLog(@"%s",__func__);

    NSLog(@"验证失败的方法,请检查你的用户名或密码是否正确,%@",error);
}


- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%s",__func__);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DIDLogIn" object:nil];
    
    [self goOnline];
    
    //启用流管理
    [_xmppStreamManagement enableStreamManagementWithResumption:YES maxTimeout:0];
}



#pragma mark -- XMPPMessage Delegate


- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"%s",__func__);
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"%s--%@",__FUNCTION__, message);
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSLog(@"%s--%@",__FUNCTION__, message);
}


#pragma mark -- Roster

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    //对方上线或离线,更新状态
    //xmppRosterDidChange
}

- (void)xmppRosterDidChange:(XMPPRoster *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RosterChanged" object:nil];
}

#pragma mark ===== 文件接收=======

//是否同意对方发文件
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didReceiveSIOffer:(XMPPIQ *)offer
{
    NSLog(@"%s",__FUNCTION__);
    [self.xmppIncomingFileTransfer acceptSIOffer:offer];
}

//存储文件 音频为amr格式  图片为jpg格式
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didSucceedWithData:(NSData *)data named:(NSString *)name
{
    XMPPJID *jid = [sender.senderJID copy];
    NSString *subject;
    NSString *extension = [name pathExtension];
    if ([@"amr" isEqualToString:extension]) {
        subject = @"voice";
    }else if([@"jpg" isEqualToString:extension]){
        subject = @"picture";
    }
    
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
    
    [message addAttributeWithName:@"from" stringValue:sender.senderJID.bare];
    [message addSubject:subject];
    
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:[XMPPStream generateUUID]];
    path = [path stringByAppendingPathExtension:extension];
    [data writeToFile:path atomically:YES];
    
    [message addBody:path.lastPathComponent];
    
    [self.xmppMessageArchivingCoreDataStorage archiveMessage:message outgoing:NO xmppStream:self.xmppStream];
}

//收到好友请求执行的方法
-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    self.fromJid = presence.from;
    UIAlertView *alert = [[UIAlertView
                           alloc]initWithTitle:@"提示:有人添加您为好友"
                          message:presence.from.user
                          delegate:self
                          cancelButtonTitle:@"拒绝"
                          otherButtonTitles:@"同意",
                          nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.xmppRoster rejectPresenceSubscriptionRequestFrom:self.fromJid];
    }
    else if (buttonIndex == alertView.firstOtherButtonIndex)
    {
         [self.xmppRoster acceptPresenceSubscriptionRequestFrom:self.fromJid andAddToRoster:YES];
    }
}


#pragma mark -- terminate
/**
 *  申请后台时间来清理下线的任务
 */
-(void)applicationWillTerminate
{
    UIApplication *app=[UIApplication sharedApplication];
    UIBackgroundTaskIdentifier taskId;
    
    taskId=[app beginBackgroundTaskWithExpirationHandler:^(void){
        [app endBackgroundTask:taskId];
    }];
    
    if(taskId==UIBackgroundTaskInvalid){
        return;
    }
    
    //只能在主线层执行
    [_xmppStream disconnectAfterSendingEndStream];
}

@end
