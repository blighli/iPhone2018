//
//  BaseNavigationController.m
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+CZ.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

/**
 * 定制UINavigationBar
 */
+ (void)initialize {
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:CZColor(40, 40, 40, 1.0),
                                            NSFontAttributeName:CZBFont(17),
                                            NSShadowAttributeName:shadow
                                            }];
    [navigationBar setBackgroundImage:[UIImage createImageWithColor:CZColor(255, 255, 255, 0.99) frame:CGRectMake(0, 0, SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

    

#pragma mark -  push 设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }

    [super pushViewController:viewController animated:animated];
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
