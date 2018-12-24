//
//  WifiViewController.h
//  School_2
//
//  Created by Ray on 15/12/15.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WifiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *getPasswordBarButton;

//未登录的按钮
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UILabel *labelSavePassword;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;




//登录成功后的view
@property (weak, nonatomic) IBOutlet UIButton *signOut2Button;
@property (weak, nonatomic) IBOutlet UILabel *successSignin;


@end
