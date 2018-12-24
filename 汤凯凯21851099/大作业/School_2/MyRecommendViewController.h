//
//  MyRecommendViewController.h
//  游园
//
//  Created by Ray on 15/12/11.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyRecommendTableViewCell.h"
@interface MyRecommendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *recommendTableView;


@end
