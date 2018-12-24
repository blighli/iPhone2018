//
//  PDGridCell.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDGridCell.h"

@interface PDGridCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *quantityLabel;

@end

@implementation PDGridCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.titleLabel.textColor = TitleTextBlackColor;
    self.quantityLabel.textColor = ContentTextColor;
}

- (void)setCellTitleWithText:(NSString *)text;
{
    self.titleLabel.text = text;
}

- (void)setQuantityWithNumber:(NSInteger)number
{
    self.quantityLabel.text = [NSString stringWithFormat:@"%@", @(number)];
}

@end
