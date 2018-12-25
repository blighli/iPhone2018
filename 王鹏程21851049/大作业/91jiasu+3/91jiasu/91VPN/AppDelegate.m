//
//  AppDelegate.m
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/27.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Config.h"
#import "CZTabBarController.h"
#import "CZLoginViewController.h"
#import "CZLoginDataModel.h"
#import "BaseNavigationController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "CZHomeModel.h"
#import "CZMessageVC.h"
#import "CZWebVC.h"
#import "CZMessageVC.h"

#import "BaseWebVC.h"


#import "CZGetIPAddress.h"
#import "CZViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[CZViewController alloc] init];
    [self.window makeKeyAndVisible];
    //配置部分第三方服务
    [self thirdServiceConfig];
    /**启动IAP工具类*/
    [[IAPManager shared] startManager];
    //获取ip地址、判断用户的所在位置
    [self getipaddress];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignAlias) name:@"loginSuccess" object:nil];
    
    BOOL isProduction = NO;
#ifdef DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {

    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Required
    [JPUSHService setupWithOption:launchOptions
                           appKey:JiGuang_Key
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    return YES;
}

- (void)getipaddress{

    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"text/html"]];
    manager.requestSerializer.timeoutInterval = 10;
    //2.封装参数
    NSDictionary *dict = @{@"ip":@"myip",
                           };
    [manager POST:@"http://ip.taobao.com/service/getIpInfo2.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success--%@--%@",[responseObject class],responseObject);
        NSString *codestr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        if([codestr intValue]==0){
            //成功
            NSString *countryStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"country_id"]];
            if ([countryStr isEqualToString:@"CN"]) {
                self.isGUONEI = YES;
            }else{
                self.isGUONEI = NO;
            }
            [self jiemian];
        }else{
            //失败
            self.isGUONEI = NO;
            [self jiemian];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
        self.isGUONEI = NO;
        [self jiemian];
    }];

}

- (void)jiemian{
    if ([MyUserInfo isLogined]) {
        if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
            [MyUserInfo clearUserInfo];
            [MyUserInfo saveInfoForkey:@"youke" value:nil];
        }else{
            [self setupHomeViewController];
        }
    }else{
        [self setupLoginViewController];
    }
}

- (void)resignAlias {
    NSString *num = [[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name];
    [JPUSHService setAlias:num completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
         NSLog(@"%ld---%@---%ld",iResCode,iAlias,seq);
    } seq:num.integerValue];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    NSLog(@"deviceToken:%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self handlePushApsDict:userInfo];
    completionHandler(UNNotificationPresentationOptionBadge); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self handlePushApsDict:userInfo];
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [self handlePushApsDict:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
/**
 *  处理推送
 *
 *  @param userInfo aps
 */
- (void)handlePushApsDict:(NSDictionary *)userInfo{
    // 取得 APNs 标准信息内容
    NSLog(@"推送userInfo:%@",userInfo);
    
    if([MyUserInfo isLogined]){
        if([userInfo objectForKey:@"aps"]){
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[userDefault objectForKey:@"MessageData"]];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            if ([[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"title"]) {
                [dic setObject:[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"title"] forKey:@"title"];
            }
            if ([[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"]) {
                [dic setObject:[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"] forKey:@"body"];
            }
            if ([userInfo objectForKey:@"url"]) {
                 [dic setObject:[userInfo objectForKey:@"url"] forKey:@"url"];
            }
            [dic setObject:[Util getNowTimeTimestamp] forKey:@"time"];
            [arr insertObject:dic atIndex:0];
            [userDefault setObject:arr forKey:@"MessageData"];
            [userDefault synchronize];
            [JPUSHService resetBadge];
            
            if (!kStringIsEmpty([userInfo objectForKey:@"url"])) {
                CZWebVC *web = [[CZWebVC alloc] init];
                if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController *tabVC = (UITabBarController  *)self.window.rootViewController;
                    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                    web.URLString =[userInfo objectForKey:@"url"];
                    [pushClassStance pushViewController:web animated:YES];
                }else if ([self.window.rootViewController isKindOfClass:[UIViewController class]]){
                    web.URLString =[userInfo objectForKey:@"url"];
                    UINavigationController *pushClassStance = (UINavigationController *)self.window.rootViewController;
                    [pushClassStance pushViewController:web animated:YES];
                }
            }else{
                CZMessageVC *mess = [[CZMessageVC alloc] init];
                if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController *tabVC = (UITabBarController  *)self.window.rootViewController;
                    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                    [pushClassStance pushViewController:mess animated:YES];
                }else if ([self.window.rootViewController isKindOfClass:[UIViewController class]]){
                    UINavigationController *pushClassStance = (UINavigationController *)self.window.rootViewController;
                    [pushClassStance pushViewController:mess animated:YES];
                }
            }
        }
    }
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}



#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setupLoginViewController
{
    CZLoginViewController *loginVC = [[CZLoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

//首页
-(void)setupHomeViewController
{
    self.window.rootViewController = [[CZTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter]postNotificationName:UIApplicationDidEnterBackgroundNotification object:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /**结束IAP工具类*/
    [[IAPManager shared] stopManager];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
     [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//        
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//        
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
@end
