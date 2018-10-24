//
//  Solution.h
//  Cal
//
//  Created by shayue on 2018/10/11.
//  Copyright © 2018 shayue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Solution : NSObject
//返回星期几
- (NSUInteger) getWhichDay : (NSDate *)date;
//返回天
- (NSUInteger) getDay : (NSDate *)date;
//返回月
- (NSUInteger) getMonth : (NSDate *)date;
//返回当前月的天数
- (NSUInteger) getMonthLength : (NSDate *)date;
//返回年
- (NSUInteger) getYear : (NSDate *)date;
//返回当前月的第一天是周几
- (NSUInteger) getFirstdayOfMonth : (NSUInteger)dayInWeek : (NSUInteger)day;
//输出一个月的日历接口
- (void) printOneMonthInterface : (NSDate*) date
								: (BOOL) Iscolor;
//格式化输出一个月的日历
- (void) printMonth : (NSUInteger)firstDayOfCurMonth
					: (NSUInteger)monthLength
					: (BOOL)IsColor
					: (NSUInteger)colorday;
//用设置好的时间返回NSDate
- (NSDate*) getSetDate : (NSUInteger)theYear : (NSUInteger)theMonth;
//打印全年的日历
- (void) printAllYear:(NSUInteger)inputYear;
//打印3个月份
- (void) printThreeMonth : (NSUInteger)i;
@end

NS_ASSUME_NONNULL_END
