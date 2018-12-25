//
//  BaseViewController.m
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)dealloc
{
    CZDealloc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CZColorHexString(#f3f3f3);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self uiConfig];
    [self requestData];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *image = [[UIImage imageNamed:@"back_bt_7h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(goback1)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

- (void)goback1 {
    [self.navigationController popViewControllerAnimated:YES];
}
//创建UI
- (void)uiConfig{
    
}
//网络请求
- (void)requestData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
