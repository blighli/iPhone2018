//
//  RegisterViewController.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import "RegisterViewController.h"
#import "XMPPManager.h"

@interface RegisterViewController ()<XMPPStreamDelegate>
//注册用户名
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
//注册密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegisterViewController
#pragma mark 点击注册执行的方法
- (IBAction)register:(id)sender {
    NSLog(@"点击注册");
//[[XMPPManager sharedInstance] loginWithName:username andPassword:password];
    [[XMPPManager sharedInstance] registerWithName:self.nameTextField.text andPassword:self.passwordTextField.text];
    
}
#pragma mark 点击取消执行的方法
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置代理
    [[XMPPManager sharedInstance].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark 注册成功执行的方法
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"注册成功");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册成功"
                                                        message:@"恭喜您注册成功"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];

    [self performSegueWithIdentifier:@"DidRegister" sender:self];
    //[self.navigationController popViewControllerAnimated:YES];
}


@end
