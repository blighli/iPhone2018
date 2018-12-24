//
//  LoginViewController.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import "LoginViewController.h"
#import "XMPPManager.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"DIDLogIn" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logIn:(id)sender
{
    NSString *username = _userName.text;
    NSString *password = _passWord.text;//12345
    
    if (!username || !password) {
        return;
    }
    [[XMPPManager sharedInstance] loginWithName:username andPassword:password];
    
    //[[XMPPManager sharedInstance] loginWithName:@"user1" andPassword:@"12345"];
    /** 给全局变量赋值. */
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.name = username;
    NSLog(@"%@",username);
    

}

#pragma mark -- 登录成功

#pragma mark - notification event

- (void)loginSuccess
{
    [self performSegueWithIdentifier:@"DidLogIn" sender:self];
}
@end
