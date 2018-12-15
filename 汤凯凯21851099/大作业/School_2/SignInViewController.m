//
//  SignInViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *SignInPassName;
@property (weak, nonatomic) IBOutlet UITextField *SignInPassword;
@property (weak, nonatomic) IBOutlet UIButton *Btn;

@end

@implementation SignInViewController

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
- (IBAction)keyboardHide:(id)sender {
    [self.SignInPassName resignFirstResponder];
    [self.SignInPassword resignFirstResponder];
}



- (IBAction)back:(id)sender {
    [self keyboardHide:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SignInButton:(id)sender {
    [self.SignInPassName resignFirstResponder];
    [self.SignInPassword resignFirstResponder];
    
    NSString *userEmail = self.SignInPassName.text;
    NSString *userPassword = self.SignInPassword.text;
    if ([userEmail isEqualToString:@""] ||
        [userPassword isEqualToString:@""]) {
        return;
    }
    MBProgressHUD *spiningActivity = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spiningActivity.labelText = @"正在登陆";
    spiningActivity.detailsLabelText = @"稍等片刻马上就好";
    spiningActivity.userInteractionEnabled = NO;
    
    [PFUser logInWithUsernameInBackground:userEmail password:userPassword block:^(PFUser *user, NSError *error) {
        NSString *errorMessage = @"登陆成功";
        
        spiningActivity.hidden = YES;
        
        if (user != nil) {
            NSString *userName = user.username;
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *main = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
            UINavigationController *mainNav =[[UINavigationController alloc]initWithRootViewController:main];
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = mainNav;

            [self.navigationController pushViewController:mainNav animated:YES];
            }else{
            errorMessage = error.localizedDescription;
        }
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: nil];
        [myAlert addAction: okAction];
        [self presentViewController:myAlert animated:YES completion:nil];
         
        
        
    }];
}





@end
