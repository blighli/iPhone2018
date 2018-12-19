//
//  PDWeekdayView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDWeekdayViewDelegate <NSObject>

@required
- (void)weekdaySelectedDate:(NSDate *)date;

@end

@interface PDWeekdayView : UIView

@property (nonatomic, weak) id<PDWeekdayViewDelegate> delegate;

- (void)setupWeekdayButtonsWithDate:(NSDate *)date;

@end
