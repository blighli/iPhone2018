//
//  tranSportViewController.h
//  School_2
//
//  Created by 汤凯凯 on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tranSportViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSArray *Title;
@property NSArray *Bus;
@property NSArray *Taxi;
@property NSArray *Final;


@end
