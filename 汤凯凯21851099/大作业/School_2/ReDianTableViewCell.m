//
//  ReDianTableViewCell.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "ReDianTableViewCell.h"

@implementation ReDianTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
    self.image1 = [UIImage imageNamed:@"实心星"];
    self.image2 = [UIImage imageNamed:@"空心星"];
    self.flag = true;
   
    // Configure the view for the selected state
}
- (IBAction)change:(id)sender {
    if(self.flag == true) {
        [self.button setImage:self.image2 forState:UIControlStateNormal];
        self.flag = false;
    }
    else{
        [self.button setImage:self.image1 forState:UIControlStateNormal];
        self.flag = true;
    }
}

@end
