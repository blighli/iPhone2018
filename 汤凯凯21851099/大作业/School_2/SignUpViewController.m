//
//  SignUpViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

#import "MBProgressHUD.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PassName;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UITextField *PassWord_2;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UIButton *Btn;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Btn.layer.cornerRadius = 10.0;
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
- (IBAction)back:(id)sender {
    [self.PassName resignFirstResponder];
    [self.PassWord resignFirstResponder];
    [self.PassWord_2 resignFirstResponder];
    [self.Name resignFirstResponder];
}



- (IBAction)Cancel:(id)sender {
    [self back:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SignUp:(id)sender {
    
    [self.PassName resignFirstResponder];
    [self.PassWord resignFirstResponder];
    [self.PassWord_2 resignFirstResponder];
    [self.Name resignFirstResponder];

    NSString *userName = self.PassName.text;
    NSString *userPassword = self.PassWord.text;
    NSString *userPasswordRepeat = self.PassWord_2.text;
    NSString *Name = self.Name.text;
    if ([userName isEqualToString:@""] ||
        [userPassword isEqualToString:@""] ||
        [userPasswordRepeat isEqualToString:@""] ||
        [Name isEqualToString:@""] ) {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所有字段必须填写" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler:nil];
        
        [myAlert addAction: okAction];
        [self presentViewController:myAlert animated:YES completion:nil];


        return;
    }
    if (![userPassword isEqualToString:userPasswordRepeat]) {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码不匹配" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler:nil];
        
        [myAlert addAction: okAction];
        [self presentViewController:myAlert animated:YES completion:nil];
        
        
        return;
    }
    
    MBProgressHUD *spiningActivity = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spiningActivity.labelText = @"正在注册";
    spiningActivity.detailsLabelText = @"稍等片刻马上就好";
    spiningActivity.userInteractionEnabled = NO;

    
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = userPassword;
    user.email = userName;
    [user setObject:Name forKey:@"Name"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        spiningActivity.hidden = YES;

        
        NSString *errorMessage = @"注册成功";
        if (error) {
            errorMessage = @"该用户名已存在，请勿重复注册！";
        }
        
            UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *okAction){
            if (!error) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        
       
        [myAlert addAction: okAction];
        [self presentViewController:myAlert animated:YES completion:nil];
    }];
    

    
}


@end
