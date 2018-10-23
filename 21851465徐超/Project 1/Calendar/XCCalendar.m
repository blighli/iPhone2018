//
//  XCCalendar.m
//  Calendar
//
//  Created by 徐超 on 2018/10/11.
//  Copyright © 2018 徐超. All rights reserved.
//

#import "XCCalendar.h"

#define DEFAULT_CALENDAR    [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]
#define NSLog(FORMAT, ...)  printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation XCCalendar

#pragma mark - Methods

+ (void)printCalendarOfYear:(NSInteger)year {
    if (year < 100) {
        NSLog(@"                             %ld", year);
    } else {
        NSLog(@"                            %ld", year);
    }
    
    NSDateComponents *today = [DEFAULT_CALENDAR components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSMutableArray<NSMutableArray *> *calendarArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 12; i++) {
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        firstDay.year = year;
        firstDay.month = i;
        firstDay.day = 1;
        NSDate *firstDayDate = [DEFAULT_CALENDAR dateFromComponents:firstDay];
        if (year == today.year && i == today.month) {
            [calendarArr addObject:[XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:today.day]];
        } else {
            [calendarArr addObject:[XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:0]];
        }
    }
    
    NSArray<NSString *> *monthName = @[@"         一月                    二月                    三月",
                                       @"         四月                    五月                    六月",
                                       @"         七月                    八月                    九月",
                                       @"         十月                   十一月                   十二月"];
    for (NSInteger i = 0; i <=3; i++) {
        NSLog(@"%@", monthName[i]);
        [XCCalendar printCalendarOfMonthFrom:(i * 3 + 1) to:((i + 1) * 3) inCalendarArray:calendarArr];
        if (i != 3) {
            NSLog(@"");
        }
    }
}

+ (void)printCalendarOfCurrentMonth {
    NSDateComponents *today = [DEFAULT_CALENDAR components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *firstDay = [[NSDateComponents alloc] init];
    firstDay.year = today.year;
    firstDay.month = today.month;
    firstDay.day = 1;
    NSDate *firstDayDate = [DEFAULT_CALENDAR dateFromComponents:firstDay];
    
    NSMutableArray* calendarArr = [XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:today.day];
    [XCCalendar printCalendarWithMonth:firstDay.month year:firstDay.year calendarArray:calendarArr];
}

+ (void)printCalendarOfThisYearsMonth:(NSInteger)month {
    NSDateComponents *today = [DEFAULT_CALENDAR components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *firstDay = [[NSDateComponents alloc] init];
    firstDay.year = today.year;
    firstDay.month = month;
    firstDay.day = 1;
    NSDate *firstDayDate = [DEFAULT_CALENDAR dateFromComponents:firstDay];
    
    NSMutableArray* calendarArr;
    if (month == today.month) {
        calendarArr = [XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:today.day];
    } else {
        calendarArr = [XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:0];
    }
    [XCCalendar printCalendarWithMonth:firstDay.month year:firstDay.year calendarArray:calendarArr];
}

+ (void)printCalendarOfMonth:(NSInteger)month inYear:(NSInteger)year {
    NSDateComponents *today = [DEFAULT_CALENDAR components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *firstDay = [[NSDateComponents alloc] init];
    firstDay.year = year;
    firstDay.month = month;
    firstDay.day = 1;
    NSDate *firstDayDate = [DEFAULT_CALENDAR dateFromComponents:firstDay];
    
    NSMutableArray* calendarArr;
    if (month == today.month && year == today.year) {
        calendarArr = [XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:today.day];
    } else {
        calendarArr = [XCCalendar calendarOfMonthWithFirstDayDate:firstDayDate todayFlag:0];
    }
    [XCCalendar printCalendarWithMonth:firstDay.month year:firstDay.year calendarArray:calendarArr];
}

#pragma mark - Utilities

/**
 *  打印单月日历.
 *
 *  @param month        指定月份.
 *  @param year         指定年份.
 *  @param calendarArr  包含日历信息的数组.
 */
+ (void)printCalendarWithMonth:(NSInteger)month year:(NSInteger)year calendarArray:(NSMutableArray<NSString *> *)calendarArr {
    NSArray *monthName = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"十一月", @"十二月"];
    NSLog(@"%@", [NSString stringWithFormat:@"      %@ %ld", monthName[month - 1], year]);
    for (NSString *str in calendarArr) {
        NSLog(@"%@", str);
    }
    NSLog(@"");
}

/**
 *  打印若干月的日历.
 *
 *  @param from         指定起始月份.
 *  @param to           指定结束月份.
 *  @param calendarArr  包含整年的格式化的日历信息的数组.
 */
+ (void)printCalendarOfMonthFrom:(NSInteger)from to:(NSInteger)to inCalendarArray:(NSMutableArray<NSMutableArray *> *)calendarArr {
    NSInteger maxLineNum = 0;
    for (NSInteger i = from - 1; i < to; i++) {
        if (calendarArr[i].count > maxLineNum) {
            maxLineNum = calendarArr[i].count;
        }
    }
    
    for (NSInteger i = from - 1; i < to; i++) {
        if (calendarArr[i].count != maxLineNum) {
            [calendarArr[i] addObject:@"                    "];
        }
    }
    
    for (NSInteger i = 0; i < maxLineNum; i++) {
        NSMutableString *str = [[NSMutableString alloc] init];
        for (NSInteger j = from - 1; j < to; j++) {
            [str appendString:calendarArr[j][i]];
            if (j != to - 1) {
                [str appendString:@"  "];
            }
        }
        NSLog(@"%@", str);
    }
}

/**
 *  根据某月第一天的Date对象，返回格式化的当月日历信息.
 *
 *  @param firstDayDate 某月第一天的Date对象.
 *  @param todayFlag    今天的标记，如果今天在这个月中，则以今天的日期作为参数；否则，以0作为参数.
 *  @return 包含格式化的一个月的日历信息的数组.
 */
+ (NSMutableArray<NSString *> *)calendarOfMonthWithFirstDayDate:(NSDate *)firstDayDate todayFlag:(NSInteger)todayFlag {
    NSDateComponents *firstDay = [DEFAULT_CALENDAR components:NSCalendarUnitWeekday fromDate:firstDayDate];
    NSRange dayOfMonth = [DEFAULT_CALENDAR rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDayDate];
    return [XCCalendar calendarOfMonthWithDayCount:dayOfMonth.length firstWeekday:firstDay.weekday todayFlag:(NSInteger)todayFlag];
}

/**
 *  指定月份的天数和第一天是星期几，返回格式化的当月日历信息.
 *
 *  @param dayCount     指定当月总天数.
 *  @param firstWeekday 指定当月第一天是星期几，从星期日开始编号，即firstWeekday=1表示星期日，firstWeekday=2表示星期一，以此类推.
 *  @param todayFlag    今天的标记，如果今天在这个月中，则传入今天的日期；否则，传入0.
 *  @return 包含格式化的一个月的日历信息的数组.
 */
+ (NSMutableArray<NSString *> *)calendarOfMonthWithDayCount:(NSInteger)dayCount firstWeekday:(NSInteger)firstWeekday todayFlag:(NSInteger)todayFlag {
    NSMutableArray<NSString *> *calendarArr = [NSMutableArray arrayWithObject:@"日 一 二 三 四 五 六"];
    NSMutableString *str = [[NSMutableString alloc] init];
    NSInteger currentWeekday = firstWeekday;
    
    for (NSInteger i = 1; i < currentWeekday; i++) {
        [str appendString:@"   "];
    }
    
    for (NSInteger i = 1; i <= dayCount; i++) {
        if (i < 10) {
            [str appendString:@" "];
        }
        if (i == todayFlag) {
            [str appendString:[NSString stringWithFormat:@"\033[7m%ld\e[0m", i]];
        } else {
            [str appendString:[NSString stringWithFormat:@"%ld", i]];
        }
        if (currentWeekday != 7) {
            [str appendString:@" "];
            currentWeekday += 1;
        } else {
            [calendarArr addObject:[NSString stringWithString:str]];
            [str deleteCharactersInRange:NSMakeRange(0, str.length)];
            currentWeekday = 1;
        }
    }
    
    if (currentWeekday != 1) {
        for (NSInteger i = currentWeekday; i <= 7; i++) {
            if (i != 7) {
                [str appendString:@"   "];
            } else {
                [str appendString:@"  "];
            }
        }
        [calendarArr addObject:str];
    }
    
    return calendarArr;
}

@end
