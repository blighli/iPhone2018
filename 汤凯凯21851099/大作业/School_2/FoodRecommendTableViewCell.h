//
//  FoodRecommendTableViewCell.h
//  School_2
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodRecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLocationLabel;

@end
