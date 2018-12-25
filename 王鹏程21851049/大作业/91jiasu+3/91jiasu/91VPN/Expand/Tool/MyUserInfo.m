//
//  MyUserInfo.m
//  GoPanda
//
//  Created by wangpengfei on 15/12/31.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import "MyUserInfo.h"
#import "CZLoginDataModel.h"
#import "AppDelegate.h"
#define canUseObj(str) ( (str != nil) && ![str isKindOfClass:[NSNull class]] )

@implementation MyUserInfo
+ (void)saveInfoForkey:(NSString *)key value:(NSString *)value{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
    
    
    
}
+ (NSString *)getInfoForkey:(NSString *)key{
    NSLog(@"*********************** %@",key);
//    if (!key) {
//        UIView * view = [[UIApplication sharedApplication].windows lastObject];
//        // 快速显示一个提示信息
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        hud.labelText = @"哈哈哈哈崩溃了吧";
//        // 隐藏时候从父控件中移除
//        hud.removeFromSuperViewOnHide = YES;
//        hud.mode = MBProgressHUDModeText;
//        // YES代表需要蒙版效果
//        //hud.dimBackground = YES;
//
//        return nil;
//    }
    if (key) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        return [userDefault objectForKey:key];
    }else{
        return nil;
    }

}
//保存数据到NSUserDefaults
+(void)saveUserInfo:(NSDictionary *)userinfo
{
    NSLog(@"%@",userinfo);

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    

    if (canUseObj([userinfo objectForKey:SHInvokerUserInfouser_pwd])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInfouser_pwd] forKey:SHInvokerUserInfouser_pwd];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInfouser_pwd];
    }

    if (canUseObj([userinfo objectForKey:SHInvokerUserInfouser_name])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInfouser_name] forKey:SHInvokerUserInfouser_name];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInfouser_name];
    }
    
    if (canUseObj([userinfo objectForKey:SHInvokerUserInforuser_token])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInforuser_token] forKey:SHInvokerUserInforuser_token];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInforuser_token];
    }
    
    if (canUseObj([userinfo objectForKey:SHInvokerUserInforuser_nickname])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInforuser_nickname] forKey:SHInvokerUserInforuser_nickname];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInforuser_nickname];
    }
    
    if (canUseObj([userinfo objectForKey:SHInvokerUserInforuser_exdate])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInforuser_exdate] forKey:SHInvokerUserInforuser_exdate];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInforuser_exdate];
    }
    
    if (canUseObj([userinfo objectForKey:SHInvokerUserInforuser_mobile])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInforuser_mobile] forKey:SHInvokerUserInforuser_mobile];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInforuser_mobile];
    }
    
    if (canUseObj([userinfo objectForKey:SHInvokerUserInforuser_message])) {
        [userDefault setObject:[userinfo objectForKey:SHInvokerUserInforuser_message] forKey:SHInvokerUserInforuser_message];
    }else{
        [userDefault setObject:@"" forKey:SHInvokerUserInforuser_message];
    }
    
    if (canUseObj([userinfo objectForKey:@"share"])) {
        [userDefault setObject:[userinfo objectForKey:@"share"] forKey:@"share"];
    }else{
        [userDefault setObject:@"" forKey:@"share"];
    }
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefault synchronize];
    
}
//从NSUserDefaults中读取数据
+ (NSDictionary*)getUserInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary * returnDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [userDefault objectForKey:SHInvokerUserInfouser_name],SHInvokerUserInfouser_name,
                                 [userDefault objectForKey:SHInvokerUserInfouser_pwd],
                                 SHInvokerUserInfouser_pwd,
                                 [userDefault objectForKey:SHInvokerUserInforuser_token],
                                 SHInvokerUserInforuser_token,
                                 [userDefault objectForKey:SHInvokerUserInforuser_nickname],
                                 SHInvokerUserInforuser_nickname,
                                 [userDefault objectForKey:SHInvokerUserInforuser_exdate],
                                 SHInvokerUserInforuser_exdate,
                                 [userDefault objectForKey:SHInvokerUserInforuser_mobile],
                                 SHInvokerUserInforuser_mobile,
                                 [userDefault objectForKey:SHInvokerUserInforuser_message],
                                 SHInvokerUserInforuser_message,
                                 [userDefault objectForKey:@"share"],
                                 @"share",
                                 nil];
    return returnDict;
}


//退出登录的时候清除数据
+ (void)clearUserInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey:SHInvokerUserInfouser_name];
    [userDefault setObject:nil forKey:SHInvokerUserInfouser_pwd];
    [userDefault setObject:nil forKey:SHInvokerUserInforuser_token];


    [userDefault setObject:nil forKey:SHInvokerUserInforuser_nickname];
    [userDefault setObject:nil forKey:SHInvokerUserInforuser_exdate];
    [userDefault setObject:nil forKey:SHInvokerUserInforuser_mobile];
    [userDefault setObject:nil forKey:SHInvokerUserInforuser_message];
[userDefault setObject:nil forKey:@"share"];
    [userDefault synchronize];
}

//判断是否登录
+ (BOOL)isLogined{
    BOOL result = NO;
    if ([[self getUserInfo] objectForKey:SHInvokerUserInforuser_token] && [[self getUserInfo]objectForKey:SHInvokerUserInfouser_pwd]) {
        result = YES;
    }
    return result;
    //    return  ([self getUserInfo] && [[[self getUserInfo]objectForKey:SHInvokerUserInfoUserId] integerValue]!=0);
}
+ (void)denglu{
    CZLoginDataModel *loginModel = [[CZLoginDataModel alloc] init];
    NSDictionary *userDic = [MyUserInfo getUserInfo];
    [loginModel denglu:[userDic objectForKey:@"user_name"] password:[userDic objectForKey:@"user_pwd"] complete:^(CZLoginDataModel *result) {
        if (result.status.integerValue==0000) {
        if (result.has.integerValue==0) {
            //登录成功
            //登录成功后跳转到首页
            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
            [userDic setObject:[NSString stringWithFormat:@"%@",result.token] forKey:@"token"];
            [MyUserInfo saveUserInfo:userDic];
            [kAppDelegate setupHomeViewController];
            
        }else if(result.has.integerValue==1){
            
            [kAppDelegate setupLoginViewController];
        }
        }
    } error:^(NSDictionary *err) {
        
    }];
    
    
}
//获取当前版本
+ (NSString *)currentVersionString{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


@end
