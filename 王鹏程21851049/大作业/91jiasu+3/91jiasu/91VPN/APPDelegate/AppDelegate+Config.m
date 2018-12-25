//
//  AppDelegate+Config.m
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/27.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "AppDelegate+Config.h"
#import "SYSafeCategory.h"
#import <UMSocialCore/UMSocialCore.h>
#import <Bugly/Bugly.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMErrorCatch/UMErrorCatch.h>

@implementation AppDelegate (Config)

- (void)thirdServiceConfig{
    //统一处理一些为数组、集合等对nil插入会引起闪退
    [SYSafeCategory callSafeCategory];
    //键盘统一收回处理
    [self configureBoardManager];
    //share
    [self configShareSDK];
    //Bugly
    [self configBugly];
    /**
     *  数组越界
     */
    [AvoidCrash becomeEffective];
    
    [[UIButton appearance] setExclusiveTouch:YES];
}

- (void)configBugly{
    [Bugly startWithAppId:Bugly_AppID];
}
#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否开启
    manager.shouldResignOnTouchOutside = YES; //控制点击背景是否手气键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条
}

- (void)configShareSDK{
#ifdef DEBUG
    [UMConfigure setLogEnabled:YES];
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
#else
#endif
    [UMConfigure initWithAppkey:USHARE_APPKEY channel:@"app store"];
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMErrorCatch initErrorCatch];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_Key appSecret:WX_Secret redirectURL:nil];
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_Key  appSecret:nil redirectURL:GuanWang_baida];
}
@end
