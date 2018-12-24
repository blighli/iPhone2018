//
//  LogoutViewController.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogoutViewController.h"
#import "XMPPManager.h"
#import "AppDelegate.h"

@interface LogoutViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation LogoutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //UILabel *textLabel = [[[UILabel alloc] init]initWithFrame:self.view.usernameLabel];
    
    
    //static NSString *indentifier = @"usernameLabel";
    //UILabel *textLabel = [label :indentifier];
    UILabel *textLabel=[[UITextField alloc]initWithFrame:CGRectMake(109, 250, 156, 56)];

    
    textLabel.textAlignment = UITextAlignmentCenter;
    
    textLabel.text = myDelegate.name;
    [self.view addSubview:textLabel];
    
    NSLog(@"logout");
    NSLog(@"%@",myDelegate.name);
}



#pragma mark - 注销

- (IBAction)logout:(id)sender
{
    [[XMPPManager sharedInstance] logOut];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"是否注销"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确认",nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
    
    }
    else if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        [self performSegueWithIdentifier:@"DidLogOut" sender:self];
    }
}
@end
