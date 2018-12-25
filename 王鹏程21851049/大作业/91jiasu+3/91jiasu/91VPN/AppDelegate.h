//
//  AppDelegate.h
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/27.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL youke;
@property (assign, nonatomic) BOOL isGUONEI;

//登录页面
-(void)setupLoginViewController;
//跳转到首页
-(void)setupHomeViewController;

@end

