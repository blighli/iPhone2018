//
// Created by 汤凯凯 on 2018/10/14.
// Copyright (c) 2018 汤凯凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarOfMonth.h"

@interface NSCalendar (CalendarUtils)
+ (NSInteger)currentYear;

+ (NSInteger)currentMonth;

+ (NSString *)getMonthStringFromNum:(NSInteger)month;

+ (CalendarOfMonth *)getCalendarOfMonthByYear:(NSInteger)year andMonth:(NSInteger)month;

+ (void)printCalendarOfMonth:(CalendarOfMonth *)calOfMon;
@end