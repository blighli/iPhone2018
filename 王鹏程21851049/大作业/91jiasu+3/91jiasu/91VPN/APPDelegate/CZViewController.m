//
//  CZViewController.m
//  91VPN
//
//  Created by weichengzong on 2017/11/13.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZViewController.h"

@interface CZViewController ()

@end

@implementation CZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    __block UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage getTheLaunchImage]];
    launchView.frame = self.view.bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    launchView.userInteractionEnabled = NO;
    [self.view addSubview:launchView];
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
