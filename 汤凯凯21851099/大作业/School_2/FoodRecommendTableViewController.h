//
//  FoodRecommendTableViewController.h
//  School_2
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodRecommendTableViewCell.h"
@interface FoodRecommendTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *foodTableView;

@end
