//
//  PDSettingDateView.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDSettingDateView.h"

@interface PDSettingDateView ()

@property (nonatomic, weak) IBOutlet UIButton *cancelBtn;
@property (nonatomic, weak) IBOutlet UIButton *doneBtn;
@property (nonatomic, weak) IBOutlet UIButton *todayBtn;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation PDSettingDateView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.cancelBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    
    self.dateLabel.textColor = TitleTextBlackColor;
    self.dateLabel.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = BackgroudGrayColor;
}

- (IBAction)cancel:(id)sender
{
    [self.delegate dateSettingCancel];
}

- (IBAction)done:(id)sender
{
    
}

- (IBAction)setToday:(id)sender
{
    
}

- (void)setupWithDate:(NSDate *)date
{
    NSInteger year = [date yearValue];
    NSInteger month = [date monthValue];
    NSInteger day = [date dayValue];
    
    NSString *text = [NSString stringWithFormat:@"%@年%@月%@日", @(year), @(month), @(day)];
    self.dateLabel.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
