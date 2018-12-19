//
//  FriendsListViewController.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import "FriendsListViewController.h"
#import "XMPPManager.h"
#import "ChatViewController.h"
#import "MJRefresh.h"

@interface FriendsListViewController ()

@property (nonatomic, strong) NSMutableArray    *friendsList;

@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.friendsList = [[NSMutableArray alloc] init];
    //获取服务器好友列表
    [[[XMPPManager sharedInstance] xmppRoster] fetchRoster];
    //监听好友变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rosterChange) name:@"RosterChanged" object:nil];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(doAdd:)];
    self.navigationItem.rightBarButtonItem = right;
    [self setupRefresh];
}

// 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
    //刷新图形时的颜色，即刷新的时候那个菊花的颜色
    refreshControl.tintColor = [UIColor redColor];
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [refreshControl endRefreshing];
    self.friendsList = nil;
    self.friendsList = [NSMutableArray arrayWithArray:[XMPPManager sharedInstance].xmppRosterMemoryStorage.unsortedUsers];
    
    NSLog(@"%@",self.friendsList);
    //获取服务器好友列表
    [[[XMPPManager sharedInstance] xmppRoster] fetchRoster];
    //监听好友变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rosterChange) name:@"RosterChanged" object:nil];
    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(doAdd:)];
//    self.navigationItem.rightBarButtonItem = right;
    [self.tableView reloadData];// 刷新tableView即可
    NSLog(@"刷新完成");
}

#pragma mark -- 添加好友
-(void)doAdd:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加好友"
                                                        message:@"请输入想要添加的好友名称"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"添加",nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *nameField = [alertView textFieldAtIndex:0];
    nameField.placeholder = @"用户名";
    [alertView show];
    
 }

#pragma mark - 手势滑动删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;//手势滑动删除
}

//左滑 删除好友
#pragma mark - 删除好友
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        XMPPUserCoreDataStorageObject *user = [self.friendsList objectAtIndex: indexPath.row];
        NSLog(@"删除的ID:%@;", user.jid);
        [[[XMPPManager sharedInstance] xmppRoster] removeUser:user.jid];
        
        //从taskarray中删除
        [self.friendsList removeObjectAtIndex:indexPath.row];
        //再将此条cell从列表删除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //刷新列表
        [self.tableView reloadData];
        NSLog(@"删除成功！");
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        NSString *username = nameField.text;

        XMPPJID *jid = [XMPPJID jidWithUser:username domain:XMPP_DOMAIN resource:@"iOS"];
        [[XMPPManager sharedInstance].xmppRoster subscribePresenceToUser:jid];

    }
}


#pragma mark -- 更新好友
- (void)rosterChange
{
    self.friendsList = [NSMutableArray arrayWithArray:[XMPPManager sharedInstance].xmppRosterMemoryStorage.unsortedUsers];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.friendsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsListCell" forIndexPath:indexPath];
    
    XMPPUserMemoryStorageObject *user = self.friendsList[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"UserImage"];
    cell.textLabel.text = user.jid.user;
    
    if ([user isOnline])
    {
        cell.detailTextLabel.text = @"[在线]";
    } else
    {
        cell.detailTextLabel.text = @"[离线]";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMPPUserMemoryStorageObject *user = self.friendsList[indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.chatJID = user.jid;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];// 修改下级页面的返回按钮，此处我是很想写到videoController中，但是backBarButtonItem的机制决定必须写在A中；

    [self.navigationController pushViewController:chatVC animated:YES];
}

@end
