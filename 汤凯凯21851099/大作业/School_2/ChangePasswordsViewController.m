//
//  ChangePasswordsViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/14.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "ChangePasswordsViewController.h"
#import "MBProgressHUD.h"
@interface ChangePasswordsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *NewPassword;
@property (weak, nonatomic) IBOutlet UITextField *Again;

@end

@implementation ChangePasswordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)OkButton:(id)sender {
//    PFUser *user = [PFUser currentUser];
//    NSString *password_1 = user.password;
    PFUser *user = [PFUser currentUser];
    NSString *passwords = [user objectForKey:@"passwords"];
    NSString *password = self.Password.text;
    NSString *newPassword = self.NewPassword.text;
    NSString *again = self.Again.text;
   // NSLog(@"%@",password_1);
    if ([password isEqualToString:@""]||[newPassword isEqualToString:@""]) {
        NSLog(@"NO");
        return;
    }
    if (![password isEqual:passwords]) {
        NSLog(@"YES");
        return;
    }
    
    if (![newPassword isEqual:again]) {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码不匹配" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: nil];
        [myAlert addAction: okAction];
        [self presentViewController:myAlert animated:YES completion:nil];

    }
    MBProgressHUD *spiningActivity = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spiningActivity.labelText = @"正在保存";
    spiningActivity.detailsLabelText = @"稍等片刻马上就好";
    spiningActivity.userInteractionEnabled = NO;
    //user.password = newPassword;
    if ([password isEqual:passwords]) {
      
       
    
    [user setObject:newPassword forKey:@"password"];
    [user setObject:newPassword forKey:@"passwords"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
            spiningActivity.hidden = YES;
        
            NSLog(@"yes!");
            NSString *errorMessage = @"修改成功";
            if (error) {
                errorMessage = @"保存失败请重试！";
            }
            
            UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *okAction){
                
            }];
            [myAlert addAction: okAction];
            [self presentViewController:myAlert animated:YES completion:nil];
            

        }];
    }
}



@end
