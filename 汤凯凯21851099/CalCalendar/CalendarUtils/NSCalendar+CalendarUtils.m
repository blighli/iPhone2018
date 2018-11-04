//
// Created by 汤凯凯 on 2018/10/14.
// Copyright (c) 2018 汤凯凯. All rights reserved.
//

#import "NSCalendar+CalendarUtils.h"


@implementation NSCalendar (CalendarUtils)
+ (CalendarOfMonth *)getCalendarOfMonthByYear:(NSInteger)year andMonth:(NSInteger)month {
    NSDateComponents *components = [NSDateComponents new];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];

    components = [calendar components:NSCalendarUnitWeekday fromDate:date];

    CalendarOfMonth *calOfMon = [[CalendarOfMonth alloc] initWithStartWeekDay:(int) [components weekday] totalDays:(int) range.length month:month year:year];

    return calOfMon;
}

+ (void)printCalendarOfMonth:(CalendarOfMonth *)calOfMon {
    // 7*3+6 = 13+1+13
    printf("%13s %-13d\n", [[self getMonthStringFromNum:calOfMon.month] UTF8String], calOfMon.year);
    printf("日 一 二 三 四 五 六\n");
    // padding
    for (int i = 0; i < calOfMon.startWeekday - 1; i++) {
        printf("   ");
    }
    int day = 1;
    while (calOfMon.totalDays >= day) {
        printf("%2d", day);
        if ((day + calOfMon.startWeekday - 1) % 7 == 0) {
            printf("\n");
        } else {
            printf(" ");
        }
        day++;
    }
    printf("\n");
}

+ (NSInteger)currentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return [components year];
}

+ (NSInteger)currentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    return [components month];
}

+ (NSString *)getMonthStringFromNum:(NSInteger)month {
    switch (month) {
        case 1:
            return @"一月";
        case 2:
            return @"二月";
        case 3:
            return @"三月";
        case 4:
            return @"四月";
        case 5:
            return @"五月";
        case 6:
            return @"六月";
        case 7:
            return @"七月";
        case 8:
            return @"八月";
        case 9:
            return @"九月";
        case 10:
            return @"十月";
        case 11:
            return @"十一月";
        case 12:
            return @"十二月";
        default:
            return @"";
    }
}

@end