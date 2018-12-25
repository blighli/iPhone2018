//
//  CZBuyViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZBuyViewController.h"
#import "CZBuyCell.h"
#import "CZHomeModel.h"
#import "CZWebVC.h"
#import "MJRefresh.h"
#import "CZVpnmanager16.h"
#import "YFRollingLabel.h"


static NSString *buyID = @"buyID";
@interface CZBuyViewController ()<UITableViewDelegate,UITableViewDataSource,IApRequestResultsDelegate>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIButton    *buyBtn;
@property (nonatomic ,strong)CZHomeModel *taocanModel;
@property (nonatomic ,strong)NSArray *dataArray;

@end

@implementation CZBuyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买套餐";
    [IAPManager shared].delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"xianluqiehuan" object:nil];
}
-(void)requestData{
    _taocanModel = [[CZHomeModel alloc] init];
    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
    [_taocanModel huoqutaocanlist:token complete:^(CZHomeModel *result) {
        if (result.status.integerValue==0000) {
            _dataArray = result.data;
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }else{
            [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            [_tableView.mj_header endRefreshing];
        }
    }];
}
- (void)uiConfig{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = CZColorHexString(#f3f3f3);
    [self.view addSubview:_tableView];
    [_tableView registerClass:[CZBuyCell class] forCellReuseIdentifier:buyID];
    
    kWeakSelf(self);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestData];
    }];

    
    [AFNetInterFaceManager Post:alertTextAPI parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSLog(@"%@",response);
        NSArray *arrary = [[dict objectForKey:@"billboard"] componentsSeparatedByString:@"   "];
        YFRollingLabel *topLabel = [[YFRollingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) textArray:arrary font:CZFont(15) textColor:CZColorHexString(#30a1e8)];
        topLabel.backgroundColor = CZColorHexString(#d1edfe);
        topLabel.speed = 1;
        [topLabel setOrientation:RollingOrientationLeft];
        [topLabel setInternalWidth:topLabel.frame.size.width / 3];;
        _tableView.tableHeaderView = topLabel;
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        YFRollingLabel *topLabel = [[YFRollingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) textArray:@[@"所有套餐均不限制流量",@"点击购买将断掉连接中的VPN保证网络正常访问"] font:CZFont(15) textColor:CZColorHexString(#30a1e8)];
        topLabel.backgroundColor = CZColorHexString(#d1edfe);
        topLabel.speed = 1;
        [topLabel setOrientation:RollingOrientationLeft];
        [topLabel setInternalWidth:topLabel.frame.size.width / 3];;
        _tableView.tableHeaderView = topLabel;
    }];
    

    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, SCREEN_WIDTH)];
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.backgroundColor = [UIColor colorWithHexString:@"#6bb2ff"];
    [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyBtn.layer.cornerRadius = SCREEN_WIDTH*0.25;
    _buyBtn.layer.masksToBounds = YES;
    [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_buyBtn];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY).offset(-40);
        make.centerX.equalTo(bgView);
        make.height.and.width.mas_equalTo(SCREEN_WIDTH*0.5);
    }];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"点击购买将断掉连接中的VPN保证网络正常访问";
//    label.font = [UIFont systemFontOfSize:14];
//    [bgView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(bgView);
//        make.top.equalTo(_buyBtn.mas_bottom).offset(50);
//    }];
    _tableView.tableFooterView = bgView;
    
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.00001;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
    {
        return 1;
    }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:buyID];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    if (indexPath.section==0) {
         cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#62afff"];
         [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else if (indexPath.section==1){
         cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#ff9e45"];
    }else if (indexPath.section==2){
         cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#a6ce37"];
    }
    cell.dic = [_dataArray objectAtIndex:indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            _buyBtn.backgroundColor = [UIColor colorWithHexString:@"#62afff"];
        }
        break;
        case 1:{
            _buyBtn.backgroundColor = [UIColor colorWithHexString:@"#ff9e45"];
        }
        break;
        case 2:{
            _buyBtn.backgroundColor = [UIColor colorWithHexString:@"#a6ce37"];
        }
        break;
        
        default:
        break;
    }
}

- (void)buyActionnew{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.section];
    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
    
    if (_dataArray.count<=0) {
        [self showTopMessage:@"请刷新套餐进行购买" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"游客模式下购买的套餐将被添加到公用的游客账号，请务必谨慎购买！强烈建议先注册账号再购买套餐！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *clAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:clAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _buyBtn.enabled = NO;
            [_taocanModel isopay:^(BOOL result) {
                _buyBtn.enabled = YES;
                if(result){
                    NSString *urlStr = nil;
                    if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                        urlStr = [NSString stringWithFormat:@"%@%@&token=%@&id=%@",Y_Address,BUY_TAOCAN,token,[dic objectForKey:@"id"]];
                    }else{
                        
                        urlStr = [NSString stringWithFormat:@"http://91jiasu.adclick.com.cn/index.php?s=%@&token=%@&id=%@",BUY_TAOCAN,token,[dic objectForKey:@"id"]];
                    }
                    
                    CZWebVC *webVC = [[CZWebVC alloc] init];
                    webVC.title = @"支付";
                    webVC.URLString = urlStr;
                    [self.navigationController pushViewController:webVC animated:YES];
                }else{
                    if (indexPath.section==0) {
                        [[IAPManager shared] requestProductWithId:@"910105011" with:dic];
                    }else if (indexPath.section==1){
                        [[IAPManager shared] requestProductWithId:@"910113022" with:dic];
                    }else if (indexPath.section==2){
                        [[IAPManager shared] requestProductWithId:@"910150033" with:dic];
                    }
                }
            }];
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        _buyBtn.enabled = NO;
        [_taocanModel isopay:^(BOOL result) {
            _buyBtn.enabled = YES;
            if(result){
                NSString *urlStr = nil;
                if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                    urlStr = [NSString stringWithFormat:@"%@%@&token=%@&id=%@",Y_Address,BUY_TAOCAN,token,[dic objectForKey:@"id"]];
                }else{
                    urlStr = [NSString stringWithFormat:@"http://91jiasu.adclick.com.cn/index.php?s=%@&token=%@&id=%@",BUY_TAOCAN,token,[dic objectForKey:@"id"]];
                }
                CZWebVC *webVC = [[CZWebVC alloc] init];
                webVC.title = @"支付";
                webVC.URLString = urlStr;
                [self.navigationController pushViewController:webVC animated:YES];
            }else{
                if (indexPath.section==0) {
                    [[IAPManager shared] requestProductWithId:@"910105011" with:dic];
                }else if (indexPath.section==1){
                    [[IAPManager shared] requestProductWithId:@"910113022" with:dic];
                }else if (indexPath.section==2){
                    [[IAPManager shared] requestProductWithId:@"910150033" with:dic];
                }
            }
        }];
    }
}
- (void)buyAction{
    [[CZVpnmanager16 shareManager] disconnectVPN];
    [self buyActionnew];
}


#pragma mark IApRequestResultsDelegate
- (void)filedWithErrorCode:(NSInteger)errorCode andError:(NSString *)error {
    
    switch (errorCode) {
        case IAP_FILEDCOED_APPLECODE:
            NSLog(@"用户禁止应用内付费购买:%@",error);
            [self showTopMessage:@"用户禁止应用内付费购买" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            break;
            
        case IAP_FILEDCOED_NORIGHT:
            NSLog(@"用户禁止应用内付费购买");
            [self showTopMessage:@"用户禁止应用内付费购买" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            break;
            
        case IAP_FILEDCOED_EMPTYGOODS:
            NSLog(@"商品为空");
            [self showTopMessage:@"商品为空" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            break;
            
        case IAP_FILEDCOED_CANNOTGETINFORMATION:
            NSLog(@"无法获取产品信息，请重试");
            [self showTopMessage:@"无法获取产品信息，请重试" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            break;
            
        case IAP_FILEDCOED_BUYFILED:
            NSLog(@"购买失败，请重试");
            [self showTopMessage:@"购买失败，请重试" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            break;
            
        case IAP_FILEDCOED_USERCANCEL:
            NSLog(@"用户取消交易");
            [self showTopMessage:@"用户取消交易" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
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
