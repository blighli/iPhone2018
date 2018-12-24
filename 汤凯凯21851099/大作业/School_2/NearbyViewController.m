//
//  NearbyViewController.m
//  游园
//
//  Created by Ray on 15/12/7.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "NearbyViewController.h"
#import "AppDelegate.h"

@implementation NearbyViewController

-(void)viewDidLoad
{
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(btnTap)];
//    self.navigationItem.leftBarButtonItem = btn;
    self.navigationItem.title = @"附近热点";
}

-(void)btnTap
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.isStartNavi = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
