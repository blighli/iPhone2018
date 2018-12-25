//
//  CZRegistViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/18.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZRegistViewController.h"
#import "CZRegistDataModel.h"
#import "UIButton+CZEdgeInsets.h"
#import "CZServiceViewController.h"
#import "CZWebVC.h"

@interface CZRegistViewController ()
{
    int timeDown; //60秒后重新获取验证码
    NSTimer *timer;
    UIView *codeView;
}

@property (nonatomic ,strong)CZRegistDataModel *checkModel;
@property (nonatomic ,strong)UITextField *numTextField;
@property (nonatomic ,strong)UITextField *codeTextField;
@property (nonatomic ,strong)UITextField *pwdoneTextField;
@property (nonatomic ,strong)UITextField *pwdtwoTextField;
@property (nonatomic ,strong)UITextField *emailTextField;
@property (nonatomic ,strong)UIButton *codeBtn;
@property (nonatomic ,strong)UIButton *emailBtn;
@end

@implementation CZRegistViewController
//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];   // 将定时器从运行循环中移除，
    timer = nil;
    //移除后台监听
    [CZHandlerEnterBackground removeNotificationObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    //进入后台再进入前台重新开始定位
    [CZHandlerEnterBackground addObserverUsingBlock:^(NSNotification * _Nonnull note, NSTimeInterval stayBackgroundTime) {
        timeDown = timeDown-stayBackgroundTime;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
//    UISegmentedControl *segView = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
//    //添加小按钮
//    [segView insertSegmentWithTitle:@"手机验证" atIndex:0 animated:NO];
//    [segView insertSegmentWithTitle:@"邮箱验证" atIndex:1 animated:NO];
//    segView.selectedSegmentIndex = 0;
//    [segView setTintColor:[UIColor colorWithHexString:@"#00cbff"]];
//    [segView addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = segView;
}
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    if (Index==0) {
        _numTextField.rightView.hidden = NO;
        _emailTextField.rightView.hidden = YES;
        _codeTextField.placeholder = @"请输入短信验证码";
        [_emailTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_numTextField.mas_bottom).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.height.mas_equalTo(0);
        }];
        
    }else if (Index==1){
        _numTextField.rightView.hidden = YES;
        _emailTextField.rightView.hidden = NO;
        _codeTextField.placeholder = @"请输入邮箱验证码";
        [_emailTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_numTextField.mas_bottom).offset(1);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.height.mas_equalTo(45);
        }];
    }
}
- (void)uiConfig{
    _numTextField = [[UITextField alloc] init];
    _numTextField.backgroundColor = [UIColor whiteColor];
    [_numTextField becomeFirstResponder];
    _numTextField.leftView = [self createrightView:@"registphone"];
    _numTextField.leftViewMode=UITextFieldViewModeAlways;
//    _numTextField.keyboardType = UIKeyboardTypeNumberPad;
    _numTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_numTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _numTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _numTextField.placeholder = @"请输入您的手机号或邮箱";
    _numTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_numTextField];
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    
    _emailTextField = [[UITextField alloc] init];
    _emailTextField.backgroundColor = [UIColor whiteColor];
    _emailTextField.leftView = [self createrightView:@"email"];
    _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailTextField.leftViewMode=UITextFieldViewModeAlways;
    _emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailTextField.placeholder = @"请输入您的邮箱";
    _emailTextField.font = [UIFont systemFontOfSize:16];
    _emailTextField.layer.masksToBounds = YES;
    [self.view addSubview:_emailTextField];
    [_emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numTextField.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(0);
    }];
    
    
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.backgroundColor = [UIColor whiteColor];
    _codeTextField.leftView = [self createrightView:@"registcode"];
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTextField.leftViewMode=UITextFieldViewModeAlways;
    _codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _codeTextField.placeholder = @"请输入收到的验证码";
    _codeTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_codeTextField];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_emailTextField.mas_bottom).offset(1);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    _pwdoneTextField = [[UITextField alloc] init];
    _pwdoneTextField.backgroundColor = [UIColor whiteColor];
    _pwdoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdoneTextField.leftView = [self createrightView:@"registmima"];
    _pwdoneTextField.leftViewMode=UITextFieldViewModeAlways;
    _pwdoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_pwdoneTextField addTarget:self action:@selector(pwdFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _pwdoneTextField.placeholder = @"请输入密码";
    _pwdoneTextField.font = [UIFont systemFontOfSize:16];
    _pwdoneTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdoneTextField];
    [_pwdoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextField.mas_bottom).offset(1);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    _pwdtwoTextField = [[UITextField alloc] init];
    _pwdtwoTextField.backgroundColor = [UIColor whiteColor];
    _pwdtwoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdtwoTextField.leftView = [self createrightView:@"registmima"];
    _pwdtwoTextField.leftViewMode=UITextFieldViewModeAlways;
    _pwdtwoTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdtwoTextField.placeholder = @"请再次确认密码";
    _pwdtwoTextField.font = [UIFont systemFontOfSize:16];
    _pwdtwoTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdtwoTextField];
    [_pwdtwoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdoneTextField.mas_bottom).offset(1);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(45);
    }];

    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#00cbff"]];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 10;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdtwoTextField.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
    }];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"注册即为同意《91加速器PRO用户协议》"];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#00cbff"] range:NSMakeRange(7, 8)];
    
    
    UIButton *xieyi = [UIButton buttonWithType:UIButtonTypeCustom];
//    [xieyi setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [xieyi  setAttributedTitle:attributedStr forState:UIControlStateNormal];
//    [xieyi setTitleColor:[UIColor colorWithHexString:@"00cbff"] forState:UIControlStateNormal];
    xieyi.titleLabel.font = [UIFont systemFontOfSize:13];
    [xieyi addTarget:self  action:@selector(xieyiAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xieyi];
    [xieyi  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(5);
        make.centerX.equalTo(loginBtn);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
    }];
    
    codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    _numTextField.rightView = codeView;
    _numTextField.rightViewMode=UITextFieldViewModeAlways;
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.layer.cornerRadius = 5;
    _codeBtn.layer.masksToBounds = YES;
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"00cbff"]];
//    _codeBtn.userInteractionEnabled=NO;
//    _codeBtn.hidden = YES;
    [_codeBtn addTarget:self action:@selector(requestCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [codeView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(codeView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    _emailTextField.rightView = emailView;
    _emailTextField.rightViewMode=UITextFieldViewModeAlways;
    _emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emailBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _emailBtn.layer.cornerRadius = 5;
    _emailBtn.layer.masksToBounds = YES;
    _emailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_emailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_emailBtn setBackgroundColor:[UIColor lightGrayColor]];
    _emailBtn.userInteractionEnabled=NO;
//    _emailBtn.hidden = YES;
    [_emailBtn addTarget:self action:@selector(requestCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [emailView addSubview:_emailBtn];
    [_emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(emailView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
//    UIButton *serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    serverBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 40);
//    [serverBtn setTitle:@"点击联系客服" forState:UIControlStateNormal];
//    [serverBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [serverBtn setImage:[UIImage imageNamed:@"servertop"] forState:UIControlStateNormal];
//    [serverBtn czButtonWithEdgeInsetsStyle:CZButtonEdgeInsetsStyleImageBottom imageTitlespace:0];
//    serverBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [serverBtn addTarget:self action:@selector(serverAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:serverBtn];
}

- (void)xieyiAction{
    CZWebVC *webVC = [[CZWebVC alloc] init];
    webVC.title = @"用户协议";
    if (kAppDelegate.isGUONEI) {
        webVC.URLString = USER_XIEYI_baida;
    }else{
        webVC.URLString = USER_XIEYI_jiasu;
    }
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)serverAction{
    CZServiceViewController *serverVc = [[CZServiceViewController alloc] init];
    [self.navigationController pushViewController:serverVc animated:YES];
}
- (void)requestData{
    _checkModel = [[CZRegistDataModel alloc] init];
}
- (void)loginAction{
     if (![Util isPhoneNumber:_numTextField.text]&&![Util isValidateEmail:_numTextField.text]) {
             [self showTopMessage:@"请输入正确的手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:2 withTapBlock:nil];
         return;
     }
     if (_codeTextField.text.length<=0) {
            [self showTopMessage:@"请输入验证码" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
         return;
     }
    if (_pwdoneTextField.text.length<6) {
            [self showTopMessage:@"密码不能小于6位" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    if (_pwdoneTextField.text.length>30||_pwdtwoTextField.text.length>30) {
        [self showTopMessage:@"密码不能大于30位" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    
     if ([_pwdoneTextField.text isEqualToString:_pwdtwoTextField.text]) {
         [_checkModel zhucezhanghao:_numTextField.text pwd:_pwdoneTextField.text repassword:_pwdtwoTextField.text reg_verify:_codeTextField.text complete:^(CZRegistDataModel *result) {
         if (result.status.integerValue==0000) {
            //注册成功
             NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
             [userDic setObject:_numTextField.text forKey:@"user_name"];
             [userDic setObject:_pwdoneTextField.text forKey:@"user_pwd"];
             [MyUserInfo saveUserInfo:userDic];
             
              [self showTopMessage:@"注册成功，正在为您登录" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
             [NSThread sleepForTimeInterval:1.0];
             if (_keep) {
                 [MyUserInfo saveInfoForkey:@"zhanghao" value:_numTextField.text];
                 [MyUserInfo saveInfoForkey:@"mima" value:_pwdoneTextField.text];
             }else{
                 [MyUserInfo saveInfoForkey:@"zhanghao" value:nil];
                 [MyUserInfo saveInfoForkey:@"mima" value:nil];
             }
             [MyUserInfo denglu];
         }else{
            [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
         }
         } error:^(NSDictionary *err) {
             
         }];
     }else
     {
        [self showTopMessage:@"两次输入的密码不一致" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
     }


}
- (void)requestCodeAction{
    
    if(_numTextField.text.length==0){
        [self showTopMessage:@"请输入手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    if ([Util isPhoneNumber:_numTextField.text]||[Util isValidateEmail:_numTextField.text]) {
        [_checkModel postYanzhenPhone:_numTextField.text complete:^(CZRegistDataModel *result) {
            NSLog(@"%@",result);
            if (result.status.integerValue==0000) {
                [_checkModel huoquyanzhengma:_numTextField.text complete:^(CZRegistDataModel *result) {
                    if (result.status.integerValue==0000) {
                        [self showTopMessage:@"验证码发送成功，请查收" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                        timeDown = 59;
                        [_codeBtn setBackgroundColor:[UIColor lightGrayColor]];
                        [_codeBtn setUserInteractionEnabled:NO];
                        [self handleTimer];
                        timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
                    }else{
                        [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                    }
                } error:^(NSDictionary *err) {
                    
                }];
            }else{
                [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        } error:^(NSDictionary *err) {
            
        }];
    }else{
        [self showTopMessage:@"请输入正确的手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
    }
    
}
-(void)handleTimer
{
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

- (void)pwdFieldDidChange:(UITextField *)theTextField{

    if (theTextField.text.length >30) {
        theTextField.text = [theTextField.text substringToIndex:30];
        return;
    }
}
- (UIView *)createrightView:(NSString *)imgstr{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50,50)];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:imgstr];
    [bgView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
    }];
    return bgView;
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
