//
//  CZChangePwdVC.m
//  91加速
//
//  Created by weichengzong on 2017/8/17.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZChangePwdVC.h"
#import "CZRegistDataModel.h"
#import "CZChangePwdTwoVC.h"
#import "UIButton+CZEdgeInsets.h"
#import "CZServiceViewController.h"

@interface CZChangePwdVC ()
{
    int timeDown; //60秒后重新获取验证码
    NSTimer *timer;
}
@property (nonatomic ,strong)UITextField *phoneTextField;
@property (nonatomic ,strong)UITextField *codeTextField;
@property (nonatomic ,strong)UIButton *codeBtn;
@property (nonatomic ,strong)CZRegistDataModel *changerModel;

@end

@implementation CZChangePwdVC
//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];   // 将定时器从运行循环中移除，
    timer = nil;
    [CZHandlerEnterBackground removeNotificationObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [CZHandlerEnterBackground addObserverUsingBlock:^(NSNotification * _Nonnull note, NSTimeInterval stayBackgroundTime) {
        timeDown = timeDown-stayBackgroundTime;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isMY) {
        self.title = @"验证手机号";
    }else{
        self.title = @"找回密码";
    }
    
}

- (void)uiConfig{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(140);
    }];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 25, SCREEN_WIDTH-160, 30)];
    _phoneTextField.placeholder = @"请输入您的用户名";
    _phoneTextField.font = [UIFont systemFontOfSize:16];
    [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    [_phoneTextField addBottomBorderWithColor:[UIColor colorWithHexString:@"#f3f3f3"] andWidth:1];
//    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_phoneTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 60, SCREEN_WIDTH-40, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    [bgView addSubview:line];
    
    if (self.isMY) {
        NSString *user_name = [[MyUserInfo getUserInfo] objectForKey:@"user_name"];
        _phoneTextField.text = user_name;
        _phoneTextField.userInteractionEnabled = NO;
    }

    _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 75, SCREEN_WIDTH-40, 40)];
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.font = [UIFont systemFontOfSize:16];
    [_codeTextField addBottomBorderWithColor:[UIColor colorWithHexString:@"#f3f3f3"] andWidth:1];
    [bgView addSubview:_codeTextField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor colorWithHexString:@"#00cbff"]];
    [searchBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 10;
    searchBtn.layer.masksToBounds = YES;
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.equalTo(bgView.mas_bottom).offset(22);
        make.height.mas_equalTo(44);
    }];

    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 25, 150, 30)];
    [bgView addSubview:codeView];



    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"00cbff"]];
    //    _codeBtn.hidden = YES;
    [_codeBtn addTarget:self action:@selector(requestCodeAction) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.cornerRadius = 5;
    _codeBtn.layer.masksToBounds = YES;
    [codeView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(codeView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    if (!self.isMY) {
       [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"00cbff"]];
//        _codeBtn.userInteractionEnabled = NO;
    }
    
    UIButton *serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    serverBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 40);
    [serverBtn setTitle:@"点击联系客服" forState:UIControlStateNormal];
    [serverBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [serverBtn setImage:[UIImage imageNamed:@"servertop"] forState:UIControlStateNormal];
    [serverBtn czButtonWithEdgeInsetsStyle:CZButtonEdgeInsetsStyleImageBottom imageTitlespace:0];
    serverBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [serverBtn addTarget:self action:@selector(serverAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serverBtn];

    
}
-(void)textFieldDidChange :(UITextField *)theTextField{
//    if (theTextField.text.length > 11) {
//        theTextField.text = [theTextField.text substringToIndex:11];
//    }
//    if (theTextField.text.length==11) {
//        [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"00cbff"]];
//        _codeBtn.userInteractionEnabled = YES;
//    }else{
//        [_codeBtn setBackgroundColor:[UIColor lightGrayColor]];
//        _codeBtn.userInteractionEnabled = NO;
//    }
}
- (void)serverAction{
    CZServiceViewController *serverVc = [[CZServiceViewController alloc] init];
    [self.navigationController pushViewController:serverVc animated:YES];
}
-(void)requestData{
    _changerModel = [[CZRegistDataModel alloc] init];
}
- (void)requestCodeAction{
    if(_phoneTextField.text.length==0){
        [self showTopMessage:@"请输入手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
     if ([Util isPhoneNumber:_phoneTextField.text]||[Util isValidateEmail:_phoneTextField.text]) {
         [_changerModel xiugaimimacode:_phoneTextField.text complete:^(CZRegistDataModel *result) {
             if (result.status.integerValue==0000) {
                 
                 [self showTopMessage:@"验证码发送成功，请查收" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                 timeDown = 59;
                 [_codeBtn setUserInteractionEnabled:NO];
                 [_codeBtn setBackgroundColor:[UIColor lightGrayColor]];
                 [self handleTimer];
                 timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
                 
             }else{
                 [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
             }
         }];
     }else{
        [self showTopMessage:@"请输入正确的手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
     }

//    if (_phoneTextField.text.length==11&&[Util isPhoneNumber:_phoneTextField.text]) {
//
//    }else{
//        [self showTopMessage:@"请输入正确的手机号" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
//    }
}
-(void)handleTimer
{
    NSLog(@"定时器-----------------");
    if(timeDown>=0)
    {
       
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        int sec = ((timeDown%(24*3600))%3600)%60;
        [_codeBtn setTitle:[NSString stringWithFormat:@"(%d)重发验证码",sec] forState:UIControlStateNormal];
        
    }
    else
    {
        [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"00cbff"]];
        [_codeBtn setUserInteractionEnabled:YES];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        
        [timer invalidate];
        
    }
    timeDown = timeDown - 1;
}
- (void)searchAction{
    if(_phoneTextField.text.length==0){
        [self showTopMessage:@"请输入手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    if ([Util isPhoneNumber:_phoneTextField.text]||[Util isValidateEmail:_phoneTextField.text]) {
        if (_codeTextField.text.length>0) {
            [_changerModel xiugaiyanzhengcode:_phoneTextField.text reg_verify:_codeTextField.text complete:^(CZRegistDataModel *result) {
                if (result.status.integerValue==0000) {
                    CZChangePwdTwoVC *twoVC = [[CZChangePwdTwoVC alloc] init];
                    twoVC.isMY = self.isMY;
                    twoVC.userphone = _phoneTextField.text;
                    [self.navigationController pushViewController:twoVC animated:YES];
                }else{
                    [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:2 withTapBlock:nil];
                }
                
            }];
        }else{
            [self showTopMessage:@"请输入验证码" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:2 withTapBlock:nil];
        }
    }else{
                [self showTopMessage:@"请输入正确的手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
    }
    
    
}
- (void)rightAction{
    
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
