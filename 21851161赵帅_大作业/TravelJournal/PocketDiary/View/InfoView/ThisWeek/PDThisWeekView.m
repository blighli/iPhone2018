//
//  PDThisWeekView.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDThisWeekView.h"
#import "PDWeekDayView.h"

@interface PDThisWeekView () <PDWeekdayViewDelegate>

@property (nonatomic, weak) IBOutlet PDWeekdayView *weekdayView;
@property (nonatomic, weak) IBOutlet UILabel *thisWeekLabel;
@property (nonatomic, weak) IBOutlet UIView *lineView;

@end

@implementation PDThisWeekView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"PDThisWeekView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.thisWeekLabel.textColor = TitleTextBlackColor;
    self.lineView.backgroundColor = BackgroudGrayColor;
    
    self.weekdayView.delegate = self;
}

- (void)setupThisWeekWithDate:(NSDate *)date
{
    [self.weekdayView setupWeekdayButtonsWithDate:date];
}

#pragma mark - PDWeekdayViewDelegate

- (void)weekdaySelectedDate:(NSDate *)date
{
    [self.delegate thisWeekSelectedDate:date];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
