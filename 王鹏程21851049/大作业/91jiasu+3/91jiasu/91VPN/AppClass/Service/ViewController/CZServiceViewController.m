//
//  CZServiceViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZServiceViewController.h"
#import "CZServerCell.h"
#import "CZHomeModel.h"
#import <TencentOpenAPI/QQApiInterface.h>


@interface CZServiceViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property (nonatomic ,strong)UITableView  *tableView;
@property (nonatomic ,strong)CZHomeModel  *serverModel;
@property (nonatomic ,strong)NSString     *phoneNum;
@property (nonatomic ,strong)NSString     *qqNum;
@property (nonatomic ,strong)NSDictionary *dataDic;
@end

@implementation CZServiceViewController

static NSString *serverID = @"serverID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客服";
}
-(void)requestData{
    _serverModel = [[CZHomeModel alloc] init];
    [_serverModel huoqukefu:nil complete:^(CZHomeModel *result) {
        if (result.status.integerValue==0000) {
            NSDictionary *dic = [result.data firstObject];
            _phoneNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"phonecn"]];
            _qqNum = [dic objectForKey:@"qq"];
            self.dataDic = dic;
            [_tableView reloadData];
        }else{
            [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
    }];
}
- (void)uiConfig{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    _tableView.backgroundColor = CZColorHexString(#f3f3f3);
    [self.view addSubview:_tableView];
    [_tableView registerClass:[CZServerCell class] forCellReuseIdentifier:serverID];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 50)];
    footLabel.font = [UIFont systemFontOfSize:13];
    footLabel.text = @"客服服务时间为每天09:30-18:00;客服电话点击即可拨打。添加QQ官方客服需要安装手机QQ";
    footLabel.numberOfLines = 0;
    [bgView addSubview:footLabel];
    _tableView.tableFooterView = bgView;
    
    _phoneNum = KEFU_PHONE;
    
    _qqNum = KEFU_QQ;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZServerCell *cell = [tableView dequeueReusableCellWithIdentifier:serverID];
    if (indexPath.section==0) {
        cell.leftImageView.image = [UIImage imageNamed:@"phone"];
        cell.titleLabel.text = @"客服电话";
        cell.rightImageView.image = [UIImage imageNamed:@"phone_right"];
        cell.contentLabel.text = _phoneNum;
    }else if (indexPath.section==1){
        cell.leftImageView.image = [UIImage imageNamed:@"qq"];
        cell.titleLabel.text = @"QQ官方客服";
        cell.rightImageView.image = [UIImage imageNamed:@"jiahao"];
        cell.contentLabel.text = _qqNum;
    }else{
        cell.titleLabel.text = @"在线客服";
        cell.contentLabel.text = @"点击联系在线客服";
        cell.leftImageView.image = [UIImage imageNamed:@"RY_Left"];
        cell.rightImageView.image = [UIImage imageNamed:@"RY_Right"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{

            if (_phoneNum) {
                NSString *jingwaiPhone = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"phone"]];
                NSString *jingneiPhone = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"phonecn"]];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择要拨打的客服电话" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *photography = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"境外用户:%@",jingwaiPhone] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",jingwaiPhone];
                        UIWebView *callWebview = [[UIWebView alloc] init];
                        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                        [self.view addSubview:callWebview];
                }];
                [alert addAction:photography];
                UIAlertAction *photography1 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"境内用户:%@",jingneiPhone] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",jingneiPhone];
                    UIWebView *callWebview = [[UIWebView alloc] init];
                    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                    [self.view addSubview:callWebview];
                }];
                [alert addAction:photography1];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            
            }else{
                [self showTopMessage:@"服务忙" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
            
        }
        break;
        case 1:{
            if (_qqNum) {
                if ([QQApiInterface isQQInstalled]) {
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",_qqNum]];
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    [self showTopMessage:@"请先安装手机QQ" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                }
            }else{
                [self showTopMessage:@"服务忙" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        }
        break;

        default:
        break;
    }
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
