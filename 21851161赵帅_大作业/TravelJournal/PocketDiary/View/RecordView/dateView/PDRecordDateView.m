//
//  PDRecordDateView.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDRecordDateView.h"

@interface PDRecordDateView ()

@property (nonatomic, retain) IBOutlet UIButton *dateButton;
@property (nonatomic, retain) IBOutlet UIImageView *dateImageView;

@end

@implementation PDRecordDateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.dateButton setTitleColor:TitleTextBlackColor forState:UIControlStateNormal];
}

- (IBAction)touchedDateButton:(id)sender
{
    [self.delegate enterSettingDateView];
}

- (void)setDateStringWithDate:(NSDate *)date
{
    NSInteger year = [date yearValue];
    NSInteger month = [date monthValue];
    NSInteger day = [date dayValue];
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    [self.dateButton setTitle:dateStr forState:UIControlStateNormal];
    [self.dateButton setTitle:dateStr forState:UIControlStateHighlighted];
}

@end
