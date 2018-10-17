//
//  XCCalendar.h
//  Calendar
//
//  Created by 徐超 on 2018/10/11.
//  Copyright © 2018 徐超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCCalendar : NSObject

/**
 *  打印指定年份的整年日历
 *  @param year 指定年份，参数范围为1..9999
 */
+ (void)printCalendarOfYear:(NSInteger)year;

/**
 *  打印当前月的日历
 */
+ (void)printCalendarOfCurrentMonth;

/**
 *  打印今年指定月份的日历
 *  @param month 指定月份，参数范围为1..12
 */
+ (void)printCalendarOfThisYearsMonth:(NSInteger)month;

/**
 *  打印指定年份的指定月份的日历
 *  @param month 指定月份，参数范围为1..12
 *  @param year 指定年份，参数范围为1..9999
 */
+ (void)printCalendarOfMonth:(NSInteger)month inYear:(NSInteger)year;

@end

NS_ASSUME_NONNULL_END
