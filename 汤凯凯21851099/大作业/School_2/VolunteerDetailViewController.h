//
//  VolunteerDetailViewController.h
//  School_2
//
//  Created by Ray on 15/12/14.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "VolunteerDetialTableViewCell.h"
@interface VolunteerDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *hobby;
@property (weak, nonatomic) IBOutlet UILabel *personality;



@end
