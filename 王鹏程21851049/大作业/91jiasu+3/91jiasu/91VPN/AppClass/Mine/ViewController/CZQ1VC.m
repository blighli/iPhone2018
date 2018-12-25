//
//  CZQ1VC.m
//  91VPN
//
//  Created by weichengzong on 2017/10/13.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZQ1VC.h"

@interface CZQ1VC ()

@end

@implementation CZQ1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"91加速器PRO";
}

- (void)uiConfig{
    UIScrollView *bgscrollView = [[UIScrollView alloc] init];
    bgscrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:bgscrollView];
    
    bgscrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, SCREEN_HEIGHT*2);
    bgView.backgroundColor = [UIColor whiteColor];
    [bgscrollView addSubview:bgView];
    
    UIImageView *imgQ1 = [[UIImageView alloc] init];
    imgQ1.backgroundColor = [UIColor redColor];
    imgQ1.image = [UIImage imageNamed:@"num1"];
    imgQ1.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, (SCREEN_WIDTH-40)*1.186);
    [bgView addSubview:imgQ1];
    
    UIImageView *imgQ2 = [[UIImageView alloc] init];
    imgQ2.backgroundColor = [UIColor redColor];
    imgQ2.image = [UIImage imageNamed:@"num2"];
    imgQ2.frame = CGRectMake(0, CGRectGetMaxY(imgQ1.frame)+20, SCREEN_WIDTH-40, (SCREEN_WIDTH-40)*0.845);
    [bgView addSubview:imgQ2];
    
    UIImageView *imgQ3 = [[UIImageView alloc] init];
    imgQ3.backgroundColor = [UIColor redColor];
    imgQ3.image = [UIImage imageNamed:@"num3"];
    imgQ3.frame = CGRectMake(0, CGRectGetMaxY(imgQ2.frame)+10,SCREEN_WIDTH-40 , (SCREEN_WIDTH-40)*0.734);
    [bgView addSubview:imgQ3];
    
    UIImageView *imgQ4 = [[UIImageView alloc] init];
    imgQ4.backgroundColor = [UIColor redColor];
    imgQ4.image = [UIImage imageNamed:@"num4"];
    imgQ4.frame = CGRectMake(0,  CGRectGetMaxY(imgQ3.frame)+20,SCREEN_WIDTH-40, (SCREEN_WIDTH-40)*0.954);
    [bgView addSubview:imgQ4];
    
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
