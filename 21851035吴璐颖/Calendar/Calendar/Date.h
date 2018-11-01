//
//  Date.h
//  Calendar
//
//  Created by wuluying on 2018/10/23.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date:NSObject

@property(nonatomic) int year;
@property(nonatomic) int month;
@property(nonatomic) int day;
@property(nonatomic) int weekday;

- (id)initWithYearMonthDay:(int)year andMonth:(int)month andDay:(int)day;
- (void)getWeekday;
+ (int)getWeekdayOfMonth:(int)year andMonth:(int)month;
- (bool)is_LeapYear;
- (void)printMonth;
- (void)printYear;
@end
