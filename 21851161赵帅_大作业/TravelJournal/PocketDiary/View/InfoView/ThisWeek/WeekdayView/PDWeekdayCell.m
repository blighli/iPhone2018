//
//  PDWeekdayCell.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDWeekdayCell.h"

@interface PDWeekdayCell ()

@property (nonatomic, weak) IBOutlet UILabel *weekdayLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel;

@end

@implementation PDWeekdayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWithWeekday:(NSString *)weekday day:(NSString *)day state:(PDWeekdayCellState)state
{
    self.weekdayLabel.text = weekday;
    self.dayLabel.text = day;
    
    switch (state)
    {
        case PDWeekdayCellStateCurrentDay:
            self.weekdayLabel.textColor = MainBlueColor;
            self.dayLabel.textColor = MainBlueColor;
            break;
            
        default:
            self.weekdayLabel.textColor = TitleTextGrayColor;
            self.dayLabel.textColor = TitleTextGrayColor;
            break;
    }
}

@end
