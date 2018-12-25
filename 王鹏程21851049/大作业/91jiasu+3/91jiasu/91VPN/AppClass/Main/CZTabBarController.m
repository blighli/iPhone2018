//
//  CZTabBarController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZTabBarController.h"
#import "BaseNavigationController.h"
#import "CZHomeViewController.h"
#import "CZBuyViewController.h"
#import "CZServiceViewController.h"
#import "CZMineViewController.h"
#import "CZTabBar.h"

@interface CZTabBarController ()

@end

@implementation CZTabBarController

+ (void)initialize {
    //d4237a
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    //    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    //item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#00cbff"];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自定义tabbar
    [self addCustomTabBar];
    [self addChildViewControllerWithClassname:[CZHomeViewController description] imagename:@"tabbar2" title:@"加速"];
    [self addChildViewControllerWithClassname:[CZBuyViewController description] imagename:@"tabbar1" title:@"购买"];
    [self addChildViewControllerWithClassname:[CZServiceViewController description] imagename:@"tabbar3" title:@"客服"];
    [self addChildViewControllerWithClassname:[CZMineViewController description] imagename:@"tabbar4" title:@"账户"];
    
}
/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    CZTabBar *customTabBar = [[CZTabBar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    
}
    
    // 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_sel"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
