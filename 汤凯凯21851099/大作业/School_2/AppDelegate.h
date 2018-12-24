//
//  AppDelegate.h
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//MapViewController中使用
@property float longitude;
@property float latitude;
@property BOOL isStartNavi;

//MyRecommendViewController和RecommendDetailController中使用
@property NSMutableArray *images;
@property NSMutableArray *kind;
@property NSMutableArray *detail;
//全局变量 用于好友的时候的跳转
@property NSInteger i;

//VolunteerDetailViewController和VolunterTableViewController中使用
@property UIImage *headImage;
@property NSString *name;
@property NSString *words;

@end

