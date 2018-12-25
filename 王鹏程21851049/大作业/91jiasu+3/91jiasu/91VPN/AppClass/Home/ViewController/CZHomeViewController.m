//
//  CZHomeViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZHomeViewController.h"
#import "CZspeedBtn.h"
#import "CZHomeModel.h"

#import "CZPingManager.h"
#import "CZUMShare.h"
#import "CZVpnmanager16.h"



@interface CZHomeViewController ()

@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *shareLabel;
@property (nonatomic ,strong)UILabel *xianluLabel;
@property (nonatomic ,strong)CZspeedBtn *speedBtn;
@property (nonatomic ,strong)CZHomeModel *homeModel;
@property (nonatomic ,strong)NSArray *serverList;
@property (nonatomic ,strong)NSMutableArray *arr;
@property (nonatomic ,assign)BOOL is_select;
@property (nonatomic ,assign)BOOL is_star;

@property (nonatomic ,strong)NSString *goodIKEv20;
@property (nonatomic ,strong)NSString *goodIKEv21;
@property (nonatomic ,strong)NSString *goodSS0;
@property (nonatomic ,strong)NSString *goodSS1;
@property (nonatomic ,strong)NSString *goodServer;

@property (nonatomic ,strong)UIView   *xiangluView;

@property (nonatomic ,assign)BOOL     serverlistshibai;

@end

@implementation CZHomeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[CZVpnmanager16 shareManager] connected:^(BOOL connected) {
        if (connected) {
            [self.speedBtn btnsuccess];
        }else{
            [self.speedBtn btndefault];
        }
    }];
    [self shuaxinData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSUserDefaults *defu = [NSUserDefaults standardUserDefaults];
    if (![[defu objectForKey:@"first"] isEqualToString:@"first"]) {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:@"first" forKey:@"first"];
         [userDefault synchronize];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"在正常使用91加速器PRO前，用户必须要下载必要的证书文件，该文件不会对手机造成任何影响，请放心下载。如果误删可在个人中心下载！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *photography = [UIAlertAction actionWithTitle:@"下载安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_homeModel getCertcomplete:^(NSDictionary *result) {
                NSLog(@"证书地址--%@",result);
                    NSString *url = [result objectForKey:@"url"];
                    NSURL *requestURL = [NSURL URLWithString:url];
                    [[UIApplication sharedApplication ] openURL: requestURL ];
            } error:^(NSDictionary *err) {
                
            }];
        }];
        [alert addAction:photography];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VPNStatusDidChangeNotification) name:ConfigVPNStatusChangeNotification object:nil];
    
    [self requestlist:YES];
}

//收到VPN变化的通知
- (void)VPNStatusDidChangeNotification
{
    if ([CZVpnmanager16 shareManager].status==shibaipeizhi) {
        [self showTopMessage:@"加速配置失败，请重试" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    
    if ([CZVpnmanager16 shareManager].status==ConfigVpnConneced) {
    //VPN连接
        [self.speedBtn btnsuccess];
        [self showTopMessage:@"加速成功" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
 
    }else if ([CZVpnmanager16 shareManager].status==ConfigVpnConnecting){
    //VPN正在连接
        [self.speedBtn start];

    }else if([CZVpnmanager16 shareManager].status==ConfigVpnDisconnected){
    //VPN连接断开
        [self.speedBtn btndefault];
        NSLog(@"%d",_is_select);
    }
}

- (void)shuaxinData{
    CZHomeModel *homeModel = [[CZHomeModel alloc] init];
    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
    [homeModel getUserinfo:token complete:^(NSDictionary *result) {
        if ([result[@"status"] integerValue]==0000) {
            NSDictionary *dic = [result objectForKey:@"data"];
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"user_name"] forKey:@"user_name"];
            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"user_pwd"] forKey:@"user_pwd"];
            [dic1 setObject:[[MyUserInfo getUserInfo] objectForKey:@"token"] forKey:@"token"];
            
            [MyUserInfo saveUserInfo:dic1];
            NSDictionary *dic2 = [MyUserInfo getUserInfo];

            _timeLabel.text = [dic2 objectForKey:@"exdate"];
            _shareLabel.text = [dic2 objectForKey:@"share"];
            
            NSString *str = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"message"]];
            if ([str isEqualToString:@"1"]) {
                _timeLabel.textColor = [UIColor lightGrayColor];
            }else{
                _timeLabel.textColor = [UIColor redColor];
            }
            NSString *str1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"hasvpn"]];
            if (str1.integerValue==0) {
                _xiangluView.hidden = YES;
            }else if (str1.integerValue==1){
                _xiangluView.hidden = NO;
            }
        }else{
            [self showTopMessage:result[@"msg"] topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
    }];
}

- (void)requestlist:(BOOL)isno{
    _homeModel = [[CZHomeModel alloc] init];
    NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
    [_homeModel huoqulist:token complete:^(NSDictionary *result) {
        if ([result[@"status"] integerValue]==0000) {
            //            _serverList = result.data;
            _serverlistshibai = NO;
            NSDictionary *dataDic = [result objectForKey:@"data"];
            
            if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
                NSArray *ikev21Arr = [dataDic objectForKey:@"IKEv21"];
                [self runGoodServer:ikev21Arr str:2];
            }else{
                NSArray *ikev20Arr = [dataDic objectForKey:@"IKEv20"];
                [self runGoodServer:ikev20Arr str:1];
            }
        }else{
            if (isno) {
                [self performSelector:@selector(requestlist:) withObject:0 afterDelay:0];
            }else{
                _serverlistshibai = YES;
                [self showTopMessage:@"获取服务器列表异常，请检查网络。" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        }
    } error:^(NSDictionary *err) {
        if (isno) {
            [self performSelector:@selector(requestlist:) withObject:0 afterDelay:0];
        }else{
            _serverlistshibai = YES;
            [self showTopMessage:@"获取服务器列表异常，请检查网络。" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
    }];
}

- (void)runGoodServer:(NSArray *)arrr str:(int )servera{
    NSMutableArray *ikev20ListArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrr) {
        [ikev20ListArr addObject:[dic objectForKey:@"host"]];
    }
    [CZPingManager getFastestAddress:ikev20ListArr finished:^(NSString *ipAddress) {
        NSLog(@"选择网络地址---%@",ipAddress);
         _goodServer = ipAddress;
    }];

}
- (void)uiConfig{
    UIImageView *topBgView = [[UIImageView alloc] init];
    topBgView.userInteractionEnabled = YES;
    
    [self.view addSubview:topBgView];

  
    if (IS_IPHONE) {
        NSLog(@"++++++++++++++++++是iphone");
        topBgView.image = [UIImage imageNamed:@"home_topBg"];
        [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
            make.left.equalTo(self.view);
            make.height.mas_equalTo(SCREEN_WIDTH*1.18);
        }];
    }else{
        NSLog(@"++++++++++++++++++是ipad");
        topBgView.image = [UIImage imageNamed:@"home_topBg_ipad"];
        [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
            make.left.equalTo(self.view);
            make.height.mas_equalTo(SCREEN_WIDTH);
        }];
    }
    
    
    UIImageView *topImg = [[UIImageView alloc] init];
    topImg.image = [UIImage imageNamed:@"logo"];
    [topBgView addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topBgView.mas_centerX);
        make.top.equalTo(topBgView).offset(100);
    }];
    
    UIView *view3 = [self create:CGRectMake(0, SCREEN_WIDTH*0.55+10, SCREEN_WIDTH, 45) imgStr:@"home_xianlu" label1:@"网络线路" label2:nil btn:@"切换网络" tag:1002];
    [self.view addSubview:view3];
    
    UIView *view1 = [self create:CGRectMake(0,CGRectGetMaxY(view3.frame)+1 , SCREEN_WIDTH, 45) imgStr:@"home_time" label1:@"有效期至" label2:nil btn:@"购买套餐" tag:1000];
    _timeLabel.text = [[MyUserInfo getUserInfo] objectForKey:@"exdate"];
    [self.view addSubview:view1];

    UIView *view2 = [self create:CGRectMake(0, CGRectGetMaxY(view1.frame)+1, SCREEN_WIDTH, 45) imgStr:@"home_share" label1:@"分享推荐" label2:nil btn:@"立即分享" tag:1001];
    [self.view addSubview:view2];
    
    view3.hidden = YES;
    _xiangluView = view3;
    
    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
        view1.hidden = YES;
        UILabel *youke = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH*0.6+10, SCREEN_WIDTH, 45) ];
        youke.textAlignment = NSTextAlignmentCenter;
        youke.text = @"游客账号随时可能被其它用户登录而无法使用";
        [self.view addSubview:youke];
    }else{
        view1.hidden = NO;
    }
    
    _speedBtn = [[CZspeedBtn alloc] init];
    [self.view addSubview:_speedBtn];
    [_speedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBgView.mas_bottom).offset(-SCREEN_WIDTH*0.45*0.5+5);
        make.centerX.equalTo(self.view);
        make.width.and.height.mas_equalTo(SCREEN_WIDTH*0.45);
    }];
    kWeakSelf(self);
    _speedBtn.action = ^(){
        NSString *styleStr = [NSString stringWithFormat:@"%@",[[MyUserInfo getUserInfo] objectForKey:@"message"]];
        NSString *exdateStr = [NSString stringWithFormat:@"%@",[[MyUserInfo getUserInfo] objectForKey:@"exdate"]];
         if ([AFNetInterFaceManager hasNetworkReachability]) {
        if ([styleStr isEqualToString:@"1"]) {
            if ([weakself compareDate:exdateStr]) {
                //连接VPN
                if (weakself.serverlistshibai) {
                    [weakself showTopMessage:@"获取服务列表异常，请重新打开应用。" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                    return ;
                }
                if (weakself.goodServer) {
                    [weakself contentVPN];
                }else{
                    [weakself showTopMessage:@"请稍等正在为您选择最优网络" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                }
            }else{
                [weakself showTopMessage:@"您的有效期不足，请先购买套餐" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        }else if([styleStr isEqualToString:@"0"]){
            if ([weakself compareDate:exdateStr]) {
                //连接VPN
                [weakself contentVPN];
            }else{
                [weakself showTopMessage:@"您的有效期不足，请先购买套餐" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        }else{
                [weakself showTopMessage:@"您的有效期不足，请先购买套餐" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
         }else{
             [weakself showTopMessage:@"网络不可用，请检查网络设置" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
         }

    };
}
- (void)contentVPN{
    _is_star = YES;
    if (_speedBtn.state==btnstartstate) {
        //正在连接
        _is_select = YES;
        [[CZVpnmanager16 shareManager] disconnectVPN];
    }else if (_speedBtn.state==btnsuccessstate){
        //连接成功
        _is_select = YES;
        [[CZVpnmanager16 shareManager] disconnectVPN];

    }else if (_speedBtn.state==btndefaultstate){
        //未连接
        [CZVpnmanager16 shareManager].vpnUserName      = [[MyUserInfo getUserInfo] objectForKey:@"user_name"];
        [CZVpnmanager16 shareManager].vpnUserpwd       = [[MyUserInfo getUserInfo] objectForKey:@"user_pwd"];
        [CZVpnmanager16 shareManager].remoteIdentifier = self.goodServer;
        [CZVpnmanager16 shareManager].severAddress     = self.goodServer;
        [[CZVpnmanager16 shareManager] connectVPN];
    }
}

//- (void)contentVPN{
//    _is_star = YES;
//    if (_speedBtn.state==btnstartstate) {
//        //正在连接
//        _is_select = YES;
//        [[CZVpnmanager shareManager] disconnectVPN];
//        [contentTimer invalidate];
//        contentTimer = nil;
//    }else if (_speedBtn.state==btnsuccessstate){
//        //连接成功
//        _is_select = YES;
//        [[CZVpnmanager shareManager] disconnectVPN];
//        [contentTimer invalidate];
//        contentTimer = nil;
//
//    }else if (_speedBtn.state==btndefaultstate){
//        //未连接
//
//        [CZVpnmanager shareManager].vpnUserName = [[MyUserInfo getUserInfo] objectForKey:@"user_name"];
//        [CZVpnmanager shareManager].vpnUserpwd = [[MyUserInfo getUserInfo] objectForKey:@"user_pwd"];
//        [CZVpnmanager shareManager].remoteIdentifier = self.goodServer;
//        [CZVpnmanager shareManager].severAddress = self.goodServer;
//
//        //                    [CZVpnmanager shareManager].vpnUserName = @"test";
//        //                    [CZVpnmanager shareManager].vpnUserpwd = @"123456";
//        //                    [CZVpnmanager shareManager].remoteIdentifier = @"ios.91jiasu.top";
//        //                    [CZVpnmanager shareManager].severAddress = @"ios.91jiasu.top";
//
//        [[CZVpnmanager shareManager] creatVPNProfile];
//        contentTimer = [NSTimer scheduledTimerWithTimeInterval:(8.0) target:self selector:@selector(contentChaoshi) userInfo:nil repeats:YES];
//    }
//
//}
- (void)contentChaoshi{
#warning 注释
//    if ([CZVpnmanager shareManager].status ==ConfigVpnConnecting) {
//        [[CZVpnmanager shareManager] disconnectVPN];
//    }
}
- (BOOL)compareDate:(NSString *)endTimeStr{
    NSDate *endTime = [Util dateFromString:endTimeStr];
    NSTimeInterval interval = [endTime timeIntervalSinceNow];
    if (interval>0) {
        return YES;
    }else{
        return NO;
    }
}

- (UIView *)create:(CGRect)rect imgStr:(NSString *)img label1:(NSString *)label1s label2:(NSString *)label2s btn:(NSString *)btnstr tag:(NSInteger)tagin{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = rect;
    
    UIImageView *rightImgView = [[UIImageView alloc] init];
    rightImgView.image = [UIImage imageNamed:img];
    [bgView addSubview:rightImgView];
    [rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(20);
        make.centerY.equalTo(bgView);
        make.height.and.width.mas_equalTo(20);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:16];
    label1.text = label1s;
    [bgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightImgView.mas_right).offset(10);
        make.centerY.equalTo(bgView);
        make.width.mas_equalTo(70);
    }];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:btnstr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#00cbff"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.tag = tagin;
    [bgView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-10);
        make.centerY.equalTo(bgView);
        make.top.equalTo(bgView);
        make.bottom.equalTo(bgView);
        make.width.mas_equalTo(70);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = label2s;
    [bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(5);
        make.right.equalTo(btn.mas_left).offset(-5);
        make.centerY.equalTo(bgView);
    }];
    
    if (tagin==1000) {
        _timeLabel = label2;
    }else if (tagin==1001){
        _shareLabel = label2;
    }else if (tagin==1002){
        _xianluLabel = label2;
        if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
            _xianluLabel.text = @"国外线路";
        }else{
         _xianluLabel.text = @"国内线路";
        }
    }
    
    return bgView;
}
- (void)btnAction:(UIButton *)btn{
    if (btn.tag==1000) {
        self.tabBarController.selectedIndex = 1;
    }else if(btn.tag==1001){
        NSString *contentStr = nil;
        if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
            contentStr = @"游客模式下分享应用而获得的奖励将被添加到公用的游客账号，建议先注册账号再分享应用！";
            if (![[MyUserInfo getInfoForkey:@"youkesharefirst"] isEqualToString:@"yes"]) {
                [MyUserInfo saveInfoForkey:@"youkesharefirst" value:@"yes"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [CZUMShare UMShare91:self];
                }];
                [alert addAction:photography];
                
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                [CZUMShare UMShare91:self];
            }
        }else{
            contentStr = @"通过您发出的分享链接每成功注册一个账号，您的账号就会累加一定免费使用时长";
            if (![[MyUserInfo getInfoForkey:@"sharefirst"] isEqualToString:@"yes"]) {
                [MyUserInfo saveInfoForkey:@"sharefirst" value:@"yes"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [CZUMShare UMShare91:self];
                }];
                [alert addAction:photography];
                
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                [CZUMShare UMShare91:self];
            }
        }

    }else if(btn.tag==1002){

        [[CZVpnmanager16 shareManager] disconnectVPN];

        if ([_xianluLabel.text isEqualToString:@"国内线路"]) {
            [MyUserInfo saveInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name] value:@"guowai"];
            
            [UIView animateWithDuration: 0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:1 options:0 animations:^{
                // 放大
                _xianluLabel.transform = CGAffineTransformMakeScale(2, 2);
//                self.view.backgroundColor = [UIColor redColor];
            }completion:^(BOOL finished) {
                _xianluLabel.transform = CGAffineTransformMakeScale(1, 1);
            }];
            [self performSelector:@selector(qiehuan) withObject:nil afterDelay:2];

            _xianluLabel.text = @"国外线路";
            _goodServer = nil;
            
        }else{
            [MyUserInfo saveInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name] value:@"guonei"];
            [UIView animateWithDuration: 0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:1 options:0 animations:^{
                // 放大
                _xianluLabel.transform = CGAffineTransformMakeScale(2, 2);
//                 self.view.backgroundColor = [UIColor blueColor];
            }completion:^(BOOL finished) {
                _xianluLabel.transform = CGAffineTransformMakeScale(1, 1);
            }];
            [self performSelector:@selector(qiehuan) withObject:nil afterDelay:2];
            _xianluLabel.text = @"国内线路";
            _goodServer = nil;
           
        }
    }
}
- (void)qiehuan{
    [self shuaxinData];
    [self requestlist:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xianluqiehuan" object:nil];
}

- (void)speedAction{


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
