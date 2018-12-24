//
//  TaskListTableViewCell.m
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/27.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "TaskListTableViewCell.h"

@implementation TaskListTableViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:20];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
