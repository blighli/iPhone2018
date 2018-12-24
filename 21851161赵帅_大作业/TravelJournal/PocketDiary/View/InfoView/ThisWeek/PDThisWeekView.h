//
//  PDThisWeekView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDThisWeekViewDelegate <NSObject>

@required
- (void)thisWeekSelectedDate:(NSDate *)date;

@end

@interface PDThisWeekView : UIView

@property (nonatomic, weak) id<PDThisWeekViewDelegate> delegate;

- (void)setupThisWeekWithDate:(NSDate *)date;

@end
