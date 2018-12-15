//
//  WifiViewController.m
//  School_2
//
//  Created by Ray on 15/12/15.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "WifiViewController.h"

@implementation WifiViewController

-(void)viewDidLoad
{
    _signInButton.backgroundColor = [UIColor redColor];
    _signOutButton.backgroundColor = [UIColor blueColor];
    _signOut2Button.backgroundColor = [UIColor redColor];
    
    _signOut2Button.hidden = YES;
    _successSignin.hidden = YES;
}


//获取密码按钮
- (IBAction)getPassword:(UIBarButtonItem *)sender {
    int a,b;
    while (true) {
        a = arc4random()%100000;
        b = arc4random()%100000;
        if (a>10000 && a<99999 && b>10000 && b<99999) {
            _userNameTextField.text = [NSString stringWithFormat:@"%d%d",a,b];
            _passwordTextField.text = [NSString stringWithFormat:@"%d%d",a,b];
            break;
        }
    }
}

//刷新按钮
- (IBAction)refresh:(UIButton *)sender {
    _userNameTextField.text = @"";
    _passwordTextField.text = @"";
}
- (IBAction)tapBackground:(id)sender {
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

//登录
- (IBAction)signIn:(UIButton *)sender {
    NSString *userName = _userNameTextField.text;
    NSString *password = _passwordTextField.text;
    if (![userName isEqual: @""] && ![password isEqual:@""])
    {
        if ([userName isEqual:password]) {
            
            _userNameTextField.hidden = YES;
            _passwordTextField.hidden = YES;
            _signOutButton.hidden = YES;
            _signInButton.hidden = YES;
            _switch1.hidden = YES;
            _switch2.hidden = YES;
            _labelPhone.hidden = YES;
            _labelSavePassword.hidden = YES;
            
            _signOut2Button.hidden = NO;
            _successSignin.hidden = NO;
            
            //左上角获取按钮变成确定
            [_getPasswordBarButton setTitle:@"确定"];
        }
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"请重新输入密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//登录后的注销
- (IBAction)signOut:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认注销？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _userNameTextField.hidden = NO;
        _passwordTextField.hidden = NO;
        _signOutButton.hidden = NO;
        _signInButton.hidden = NO;
        _switch1.hidden = NO;
        _switch2.hidden = NO;
        _labelPhone.hidden = NO;
        _labelSavePassword.hidden = NO;
        
        _signOut2Button.hidden = YES;
        _successSignin.hidden = YES;
        
        [_getPasswordBarButton setTitle:@"获取无线密码"];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

//未登录前的注销
- (IBAction)signOut2:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已重置该账户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}




@end
