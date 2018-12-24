//
//  ShopViewController.m
//  School_2
//
//  Created by Ray on 15/12/18.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "ShopViewController.h"

@implementation ShopViewController

-(void)viewDidLoad
{
    NSURL* url = [NSURL URLWithString:@"http://www.duiba.com.cn/test/demoRedirectSAdfjosfdjdsa"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_shopWebView loadRequest:request];
}


@end
