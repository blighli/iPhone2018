//
//  MainViewController.h
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AMapNaviKit/AMapNaviKit.h>
//#import <iflyMSC/IFlyMSC.h>
@interface MainViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic, strong) AMapNaviManager *naviManager;
@property (nonatomic, strong) AMapNaviViewController *naviViewController;
//@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@property (weak, nonatomic) IBOutlet UITextField *searchBar;

@end
