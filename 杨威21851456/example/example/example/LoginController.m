
//
//  LoginController.m
//  在线学习平台
//
//  Created by Xia Wei on 17/4/15.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import "LoginController.h"
#import "RegisterViewController.h"
#import "FMDB.h"
#import "DataBase.h"

#define DEVICE_WIDTH self.view.frame.size.width
#define DEVICE_HEIGHT self.view.frame.size.height

@interface LoginController ()<UITextFieldDelegate>{
    UITextField *_account;
    UITextField *_password;
}

@end

enum AccountState{
    Account_Inexistent = -1,
    Password_incorrect = -2,
};


@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self initUI];
    //[[DataBase sharedDataBase]deleteTable:@"user"];
   // [[DataBase sharedDataBase]deleteAllFromTable:@"user"];
    [[DataBase sharedDataBase]printSqlUserTable];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    CGFloat origin_x = 15;
    CGFloat bottomLineHeight = 1;
    
    UIImageView *background_imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [background_imageview setImage:[UIImage imageNamed:@"login_background"]];
    [self.view addSubview:background_imageview];
    
    //设置用户名框框
    _account = [[UITextField alloc]initWithFrame:CGRectMake(origin_x, (DEVICE_HEIGHT / 2.0) - 100,DEVICE_WIDTH - 2 * origin_x, 40)];
    _account.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _account.textColor = [UIColor whiteColor];
    [_account setBorderStyle:UITextBorderStyleNone];
    _account.delegate = self;
    [self.view addSubview:_account];
    
    //用户名下方横线
    UILabel *account_bottomline = [[UILabel alloc]initWithFrame:CGRectMake(origin_x, (_account.frame.origin.y + _account.frame.size.height), _account.frame.size.width, bottomLineHeight)];
    [account_bottomline setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:account_bottomline];
    
    //设置密码
    _password = [[UITextField alloc]initWithFrame:CGRectMake(origin_x, _account.frame.origin.y + _account.frame.size.height + 15,DEVICE_WIDTH - 2 * origin_x, 40)];
    _password.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _password.textColor = [UIColor whiteColor];
    [_password setBorderStyle:UITextBorderStyleNone];
    _password.secureTextEntry = YES;
    _password.delegate = self;
    [self.view addSubview:_password];
    
    //密码下方横线
    UILabel *password_bottomline = [[UILabel alloc]initWithFrame:CGRectMake(origin_x, (_password.frame.origin.y + _password.frame.size.height), _password.frame.size.width, bottomLineHeight)];
    [password_bottomline setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:password_bottomline];
    
    //登陆按钮
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [login setFrame:CGRectMake(origin_x, _password.frame.origin.y + _password.frame.size.height + 20, _password.frame.size.width, 52)];
    UIColor *button_bgc = [UIColor colorWithRed:-0/255.0 green:227/255.0 blue:163/255.0 alpha:1];
    [login setBackgroundColor:button_bgc];
    [login setTintColor:[UIColor whiteColor]];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font = [UIFont systemFontOfSize:18];
    [login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    //用户注册
    UIButton *reg_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reg_btn setFrame:CGRectMake(login.frame.origin.x + login.frame.size.width - 80, login.frame.origin.y + login.frame.size.height + 15, 80, 15)];
    [reg_btn setTintColor:[UIColor whiteColor]];
    [reg_btn addTarget:self action:@selector(moveToRegister) forControlEvents:UIControlEventTouchUpInside];
    [reg_btn setTitle:@"用户注册" forState:UIControlStateNormal];
    [self.view addSubview:reg_btn];
}

- (void)loginAction{
    UserModel* user = [[UserModel alloc]init];
    user.userName = _account.text;
    user.password = _password.text;
    //[[DataBase sharedDataBase]printSqlTable:@"user"];
    //如果用户验证成功就登陆
    user.userID = [[DataBase sharedDataBase] checkUser:user];
    if (user.userID != Account_Inexistent) {
//        [[UserSingleton sharedUser]setUser:user];
//        RootTabBarController *rootVC = [[RootTabBarController alloc]init];
//        [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
        NSLog(@"登陆成功");
    }
    //否则弹出警告框
    else{
        UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请输入正确的账号和密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:okAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)moveToRegister{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [registerVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_password resignFirstResponder];
    [_account resignFirstResponder];
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
