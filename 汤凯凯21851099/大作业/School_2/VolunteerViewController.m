//
//  VolunteerViewController.m
//  游园
//
//  Created by Ray on 15/12/8.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "VolunteerViewController.h"

@implementation VolunteerViewController

-(void)viewDidLoad
{
    self.navigationItem.title = @"呼叫志愿者";
    
    [_callVolunteerBtn.layer setMasksToBounds:YES];
    //按钮加边框
    _callVolunteerBtn.layer.borderWidth = 1.5;
    //按钮加圆角
    [_callVolunteerBtn.layer setCornerRadius:10.0];
    [self.view bringSubviewToFront:_callVolunteerBtn];
    
    [_becomeVolunteer.layer setMasksToBounds:YES];
    [_becomeVolunteer.layer setCornerRadius:10.0];
    _becomeVolunteer.layer.borderWidth = 1.5;
    [self.view bringSubviewToFront:_becomeVolunteer];
    
    [self.view bringSubviewToFront:_welcomeLabel];
}

- (IBAction)callVolunteerButton:(UIButton *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"志愿者将会收到您的位置和消息" message:@"请在原地稍后等待，志愿者很快就会过来" preferredStyle: UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:action];
//    [self presentViewController:alert animated:YES completion:nil];
}


@end
