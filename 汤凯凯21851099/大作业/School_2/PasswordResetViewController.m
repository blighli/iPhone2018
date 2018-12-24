//
//  PasswordResetViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/10.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "PasswordResetViewController.h"

@interface PasswordResetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation PasswordResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)Send:(id)sender {
    NSString *emailAddress = self.email.text;
    if ([emailAddress isEqualToString:@""]) {
        return;
    }
    [PFUser requestPasswordResetForEmailInBackground:(emailAddress) block:^(BOOL succeeded, NSError *error){
        if (error != nil) {
            [self displayMessage:error.localizedDescription];
            
        }else{
            [self displayMessage:@"重置密码信息已经发送到您的Email里！"];
        }
    }];
    
}


- (void) displayMessage:(NSString *)errorMessage{
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: nil];
    [myAlert addAction: okAction];
    [self presentViewController:myAlert animated:YES completion:nil];

}


@end
