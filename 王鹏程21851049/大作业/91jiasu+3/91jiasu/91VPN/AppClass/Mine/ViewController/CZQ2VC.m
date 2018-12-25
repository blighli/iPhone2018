//
//  CZQ2VC.m
//  91VPN
//
//  Created by weichengzong on 2017/10/13.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZQ2VC.h"

@interface CZQ2VC ()

@end

@implementation CZQ2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"91加速器PRO";
}
- (void)uiConfig{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    NSString *Qstr = @"如果连不上，可能的情况有：\n\n 1、请检查当前手机网络是否通畅，当前网络无法连接到服务器，可尝试切换WIFI和4G信号再连接；\n\n2、如果网络正常但是无法连接，请查看使用教程，是否已经安装了必要的证书文件和配置文件；\n\n3、偶然性的连接不上，可以再次尝试连接；\n\n4、不同网络运营商，所适合的服务线路稳定性和速度有差异；\n\n5、联系客服为您解决使用问题。";
    
    UILabel *bglabel = [[UILabel alloc] init];
    bglabel.text = Qstr;
    bglabel.font = CZFont(15);
    bglabel.numberOfLines = 0;
    [bgView addSubview:bglabel];
    [bglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(10);
        make.left.equalTo(bgView).offset(10);
        make.right.equalTo(bgView).offset(-10);
    }];
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
