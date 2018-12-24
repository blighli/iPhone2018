//
//  ReDianTableViewCell.h
//  School_2
//
//  Created by 汤凯凯 on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReDianTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;

@property UITapGestureRecognizer *tap;
@property UIImage *image1;
@property UIImage *image2;
@property BOOL *flag;
@property (weak, nonatomic) IBOutlet UIImageView *TouXiang;
@property (weak, nonatomic) IBOutlet UILabel *Dymanic;

@end
