//
//  PDQuestionInfoCell.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/27.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDQuestionInfoCell.h"

@interface PDQuestionInfoCell ()

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *quantityLabel;

@end

@implementation PDQuestionInfoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.questionLabel.textColor = TitleTextBlackColor;
    self.quantityLabel.textColor = ContentTextColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithQuestionContent:(NSString *)text quantity:(NSInteger)quantity
{
    self.questionLabel.text = text;
    self.quantityLabel.text = [NSString stringWithFormat:@"%@", @(quantity)];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
