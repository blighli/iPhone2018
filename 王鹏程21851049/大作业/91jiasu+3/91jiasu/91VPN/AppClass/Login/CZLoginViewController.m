//
//  CZLoginViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZLoginViewController.h"
#import "CZRegistViewController.h"
#import "CZLoginDataModel.h"
#import "CZTabBarController.h"
#import "CZChangePwdVC.h"
#import "UIButton+CZEdgeInsets.h"
#import "CZServiceViewController.h"
#import "JPUSHService.h"

@interface CZLoginViewController ()
{
    NSString *youkeNum;
    NSString *youkeMima;
}

@property (nonatomic ,strong)UITextField      *accountTextField;
@property (nonatomic ,strong)UITextField      *pwdTextField;
@property (nonatomic ,strong)CZLoginDataModel *loginModel;

@property (nonatomic ,strong)UIButton         *keepBtn;

@end

@implementation CZLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:nil];
}

- (void)uiConfig{

    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(topView.mas_width).multipliedBy(0.6);
    }];
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"logo"];
    [topView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.backgroundColor = [UIColor whiteColor];
    _accountTextField.leftView = [self createrightView:@"username_input_icon"];
    _accountTextField.leftViewMode=UITextFieldViewModeAlways;
    _accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _accountTextField.placeholder = @"请输入您的用户名";
    _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountTextField.font = CZFont(16);
    [self.view addSubview:_accountTextField];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(45);
    }];
    _accountTextField.text = [MyUserInfo getInfoForkey:@"zhanghao"];
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.backgroundColor = [UIColor whiteColor];
    _pwdTextField.leftView = [self createrightView:@"password_input_icon"];
    _pwdTextField.leftViewMode=UITextFieldViewModeAlways;
    _pwdTextField.placeholder = @"请输入您的密码";
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.font = CZFont(16);
    [self.view addSubview:_pwdTextField];
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountTextField.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(45);
    }];
    _pwdTextField.text = [MyUserInfo getInfoForkey:@"mima"];
    
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#00cbff"]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdTextField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
    }];
    WEAK
//    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        STRONG
//
//
//    }];
    
    UIButton *youkeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [youkeBtn setBackgroundColor:[UIColor colorWithHexString:@"#34c8c6"]];
    [youkeBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    youkeBtn.layer.cornerRadius = 20;
    youkeBtn.layer.masksToBounds = YES;
    [self.view addSubview:youkeBtn];
    [youkeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
    }];
    [[youkeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG;
        [self youkeBtnAction];
    }];
    
    
    UIButton *creatAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [creatAccountBtn setBackgroundColor:[UIColor whiteColor]];
    [creatAccountBtn setTitle:@"创建账号" forState:UIControlStateNormal];
    [creatAccountBtn setTitleColor:[UIColor colorWithHexString:@"00cbff"] forState:UIControlStateNormal];
    creatAccountBtn.layer.cornerRadius = 20;
    creatAccountBtn.layer.masksToBounds = YES;
    [self.view addSubview:creatAccountBtn];
    [creatAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youkeBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
    }];
    [[creatAccountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        CZRegistViewController *registVC = [[CZRegistViewController alloc] init];
        registVC.keep = _keepBtn.selected;
        [self.navigationController pushViewController:registVC animated:YES];
    }];
    
    
    _keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_keepBtn setImage:[UIImage imageNamed:@"keep"] forState:UIControlStateNormal];
    [_keepBtn setImage:[UIImage imageNamed:@"keep_sel"] forState:UIControlStateSelected];
    [_keepBtn setTitle:@"记住我" forState:UIControlStateNormal];
    _keepBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_keepBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _keepBtn.selected = YES;
    [self.view addSubview:_keepBtn];
    _keepBtn.frame = CGRectMake(20, SCREEN_WIDTH*0.6+245+55, 100, 40);
    [_keepBtn czButtonWithEdgeInsetsStyle:CZButtonEdgeInsetsStyleImageLeft imageTitlespace:10];
    [[_keepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !_keepBtn.selected;
    }];
    
    
    UIButton *backPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    backPwdBtn.titleLabel.font = CZFont(13);
    [backPwdBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:backPwdBtn];
    [backPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(creatAccountBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    [[backPwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        CZChangePwdVC *changeVC = [[CZChangePwdVC alloc] init];
        [self.navigationController pushViewController:changeVC animated:YES];
    }];
    
//    UIButton *serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    serverBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 40);
//    [serverBtn setTitle:@"点击联系客服" forState:UIControlStateNormal];
//    [serverBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [serverBtn setImage:[UIImage imageNamed:@"servertop"] forState:UIControlStateNormal];
//    [serverBtn czButtonWithEdgeInsetsStyle:CZButtonEdgeInsetsStyleImageBottom imageTitlespace:0];
//    serverBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:serverBtn];
//    [[serverBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//        STRONG
//        CZServiceViewController *serverVc = [[CZServiceViewController alloc] init];
//        [self.navigationController pushViewController:serverVc animated:YES];
//    }];
    
}

- (void)youkeBtnAction{

    [AFNetInterFaceManager Post:visitorAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        youkeNum = [response objectForKey:@"username"];
        youkeMima = [response objectForKey:@"password"];
        [MyUserInfo saveInfoForkey:@"youke" value:[response objectForKey:@""]];
        [_loginModel denglu:[response objectForKey:@"username"] password:[response objectForKey:@"password"] complete:^(CZLoginDataModel *result) {
            if (result.status.integerValue==0000) {
                
                if (result.has.integerValue==0) {
                    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
                    [userDic setObject:youkeNum forKey:@"user_name"];
                    [userDic setObject:youkeMima forKey:@"user_pwd"];
                    [userDic setObject:[NSString stringWithFormat:@"%@",result.token] forKey:@"token"];
                    [MyUserInfo saveUserInfo:userDic];
                    [MyUserInfo saveInfoForkey:@"youke" value:@"yes"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                    CZTabBarController *tabbar = [[CZTabBarController alloc] init];
                    self.view.window.rootViewController = tabbar;
                    
                }else if (result.has.integerValue==1){
                    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                    [param setObject:youkeNum forKey:@"username"];
                    [param setObject:youkeMima forKey:@"password"];
                    [param setObject:result.token forKey:@"token"];

                      [AFNetInterFaceManager Post:Login2API hostUrl:A_Address parameters:param success:^(NSDictionary *response, NSURLSessionDataTask *task) {
                        if ([[response objectForKey:@"status"] integerValue]==0000) {
                            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
                            [userDic setObject:youkeNum forKey:@"user_name"];
                            [userDic setObject:youkeMima forKey:@"user_pwd"];
                            [userDic setObject:[NSString stringWithFormat:@"%@",result.token] forKey:@"token"];
                            [MyUserInfo saveUserInfo:userDic];
                            kAppDelegate.youke = YES;
                            [MyUserInfo saveInfoForkey:@"youke" value:@"yes"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                            CZTabBarController *tabbar = [[CZTabBarController alloc] init];
                            self.view.window.rootViewController = tabbar;
                        }
                    } failure:^(NSError *error, NSURLSessionDataTask *task) {
                        
                    }];
                    
                }

            }else{
                
                [MyUserInfo clearUserInfo];
                [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        } error:^(NSDictionary *err) {
            
        }];

        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        
    }];
}

- (void)requestData{
    _loginModel = [[CZLoginDataModel alloc] init];
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

- (void)loginAction{

    if(_accountTextField.text.length==0){
        [self showTopMessage:@"请输入手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        return;
    }
    if ([Util isPhoneNumber:_accountTextField.text]||[Util isValidateEmail:_accountTextField.text]) {
        if (_pwdTextField.text.length>=6&&_pwdTextField.text.length<=30) {
            [_loginModel denglu:_accountTextField.text password:_pwdTextField.text complete:^(CZLoginDataModel *result) {
                if (result.status.integerValue==0000) {
                    if (result.has.integerValue==0) {
                        
                        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
                        [userDic setObject:_accountTextField.text forKey:@"user_name"];
                        [userDic setObject:_pwdTextField.text forKey:@"user_pwd"];
                        [userDic setObject:[NSString stringWithFormat:@"%@",result.token] forKey:@"token"];
                        [MyUserInfo saveUserInfo:userDic];
                        //登录成功
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                        if (_keepBtn.selected) {
                            [MyUserInfo saveInfoForkey:@"zhanghao" value:_accountTextField.text];
                            [MyUserInfo saveInfoForkey:@"mima" value:_pwdTextField.text];
                        }else{
                            [MyUserInfo saveInfoForkey:@"zhanghao" value:nil];
                            [MyUserInfo saveInfoForkey:@"mima" value:nil];
                        }
                        CZTabBarController *tabbar = [[CZTabBarController alloc] init];
                        self.view.window.rootViewController = tabbar;
                        
                    }else if (result.has.integerValue==1){
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到您的账号已在其它设备上登录，是否强制在本设备上登录？登录后其它设备上本应用将无法正常使用" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *photography = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                            [param setObject:_accountTextField.text forKey:@"username"];
                            [param setObject:_pwdTextField.text forKey:@"password"];
                            [param setObject:result.token forKey:@"token"];
                            

                            [AFNetInterFaceManager Post:Login2API hostUrl:A_Address parameters:param success:^(NSDictionary *response, NSURLSessionDataTask *task) {
                                if ([[response objectForKey:@"status"] integerValue]==0000) {
                                    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
                                    [userDic setObject:_accountTextField.text forKey:@"user_name"];
                                    [userDic setObject:_pwdTextField.text forKey:@"user_pwd"];
                                    [userDic setObject:[NSString stringWithFormat:@"%@",result.token] forKey:@"token"];
                                    [MyUserInfo saveUserInfo:userDic];
                                    //登录成功
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                                    if (_keepBtn.selected) {
                                        [MyUserInfo saveInfoForkey:@"zhanghao" value:_accountTextField.text];
                                        [MyUserInfo saveInfoForkey:@"mima" value:_pwdTextField.text];
                                    }else{
                                        [MyUserInfo saveInfoForkey:@"zhanghao" value:nil];
                                        [MyUserInfo saveInfoForkey:@"mima" value:nil];
                                    }
                                    CZTabBarController *tabbar = [[CZTabBarController alloc] init];
                                    self.view.window.rootViewController = tabbar;
                                }
                            } failure:^(NSError *error, NSURLSessionDataTask *task) {
                                
                            }];
                            
                            
                        }];
                        [alert addAction:photography];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:cancelAction];
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }else{
                    
                    [MyUserInfo clearUserInfo];
                    [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                }
            } error:^(NSDictionary *err) {
                
            }];
        }else{
            [self showTopMessage:@"请输入6~30位密码" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
    }else{
        [self showTopMessage:@"请输入正确的手机号或邮箱" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
