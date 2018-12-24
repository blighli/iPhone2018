//
//  SystemViewViewController.m
//  School_2
//
//  Created by Ray on 15/12/20.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "SystemViewViewController.h"

@implementation SystemViewViewController

-(void)viewDidLoad{
    [_imageView.layer setMasksToBounds:YES];
    //按钮加圆角
    [_imageView.layer setCornerRadius:10.0];
}

@end
