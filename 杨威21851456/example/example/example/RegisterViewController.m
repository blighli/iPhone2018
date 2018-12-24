//
//  RegisterViewController.m
//  在线学习平台
//
//  Created by Xia Wei on 17/4/15.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserModel.h"
#import "UIView+RSAdditions.h"
#import "DataBase.h"
#import "UserModel.h"
#define DEVICE_WIDTH self.view.frame.size.width
#define DEVICE_HEIGHT self.view.frame.size.height

@interface RegisterViewController ()<UITextFieldDelegate>{
    UITextField *_account;
    UITextField *_password;
    UITextField *_affirmTF;
    UITextField *_nickName;
}

@end

enum AccountState{
    Account_Inexistent = -1,
    Password_incorrect = -2,
};

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self initUI];
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
    
    //设置昵称框框
    _nickName = [[UITextField alloc]initWithFrame:CGRectMake(origin_x,_account.top - 55,DEVICE_WIDTH - 2 * origin_x, 40)];
    _nickName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"填写昵称" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _nickName.textColor = [UIColor whiteColor];
    [_nickName setBorderStyle:UITextBorderStyleNone];
    _nickName.delegate = self;
    [self.view addSubview:_nickName];
    
    //昵称下方横线
    UILabel *nickName_bottomline = [[UILabel alloc]initWithFrame:CGRectMake(origin_x, _nickName.bottom, _account.frame.size.width, bottomLineHeight)];
    [nickName_bottomline setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:nickName_bottomline];

    
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
    
    //确认密码
    _affirmTF = [[UITextField alloc]initWithFrame:CGRectMake(origin_x, _password.frame.origin.y + _password.frame.size.height + 15,DEVICE_WIDTH - 2 * origin_x, 40)];
    _affirmTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _affirmTF.textColor = [UIColor whiteColor];
    [_affirmTF setBorderStyle:UITextBorderStyleNone];
    _affirmTF.secureTextEntry = YES;
    _affirmTF.delegate = self;
    [self.view addSubview:_affirmTF];
    
    //确认密码下方横线
    UILabel *affirm_bottomline = [[UILabel alloc]initWithFrame:CGRectMake(origin_x, (_affirmTF.frame.origin.y + _affirmTF.frame.size.height), _affirmTF.frame.size.width, bottomLineHeight)];
    [affirm_bottomline setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:affirm_bottomline];
    
    //登陆按钮
    UIButton *registerUI = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerUI setFrame:CGRectMake(origin_x, _affirmTF.frame.origin.y + _affirmTF.frame.size.height + 20, _affirmTF.frame.size.width, 52)];
    UIColor *button_bgc = [UIColor colorWithRed:-0/255.0 green:227/255.0 blue:163/255.0 alpha:1];
    [registerUI setBackgroundColor:button_bgc];
    [registerUI setTintColor:[UIColor whiteColor]];
    [registerUI setTitle:@"注册用户" forState:UIControlStateNormal];
    registerUI.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerUI addTarget:self action:@selector(registerUserID) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerUI];
    
    //关闭返回登陆按钮
    UIButton *backToLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *login_image = [UIImage imageNamed:@"ToLogin"];
    [backToLogin setBackgroundImage:login_image forState:UIControlStateNormal];
    CGFloat btn_width = 40;
    CGFloat btn_height = 24;
    [backToLogin setFrame:CGRectMake((DEVICE_WIDTH - btn_width) / 2.0,DEVICE_HEIGHT - btn_height - 20, btn_width, btn_height)];
    [backToLogin addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToLogin];
}

//弹窗警告
- (void)alerAction:(NSString *)title Message:(NSString *)message{
    UIAlertController* alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if ([title  isEqual: @"注册成功"]) {
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self backToLogin];
        }];
        [alertC addAction:okAction];
    }
    else{
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:okAction];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}



//注册的方法
- (void)registerUserID{
    NSString* passwordStr = _password.text;
    NSString* affirmStr = _affirmTF.text;
    NSString* accountStr = _account.text;
    NSString* nickNameStr = _nickName.text;
    //如果用户名为空则弹框警告
    if ([accountStr  isEqual: @""]) {
        [self alerAction:@"注册失败" Message:@"用户名不能为空！"];
        return;
    }
    if([passwordStr  isEqual: @""]){
        [self alerAction:@"注册失败" Message:@"密码不能为空！"];
        return;
    }
    if([affirmStr  isEqual: @""]){
        [self alerAction:@"注册失败" Message:@"请再输入一次密码！"];
        return;
    }
    if ([nickNameStr  isEqual: @""]) {
        [self alerAction:@"注册失败" Message:@"昵称不能为空！"];
        return;
    }
    //如果两次密码不一致则报错
    if ([passwordStr isEqualToString:affirmStr]) {
        UserModel* user = [[UserModel alloc]init];
        user.userName = _account.text;
        user.password = _password.text;
        user.nickName = _nickName.text;
        //判断用户名是否存在
        if([[DataBase sharedDataBase]checkUser:user] != Account_Inexistent){
            [self alerAction:@"注册失败" Message:@"用户名已存在"];
        }
        else{
            [self alerAction:@"注册成功" Message:@""];
        }
        [[DataBase sharedDataBase]addUser:user];
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self alerAction:@"注册失败" Message:@"两次密码不一致"];
    }
}

//返回登陆界面
- (void)backToLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
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



@end
