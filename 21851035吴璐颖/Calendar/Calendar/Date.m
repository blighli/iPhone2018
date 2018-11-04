//
//  Date.m
//  Calendar
//
//  Created by wuluying on 2018/10/23.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import "Date.h"

@implementation Date

//init
- (id)initWithYearMonthDay:(int)year andMonth:(int)month andDay:(int)day {
    self = [super init];
    if (self != nil) {
        _year = year;
        _month = month;
        _day = day;
    }
    return self;
}

//根据日期获取星期
- (void)getWeekday {
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:self.day];
    [comp setMonth:self.month];
    [comp setYear:self.year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comp];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    self.weekday = (int)[weekdayComponents weekday];
}

//根据日期获取星期
+ (int)getWeekdayOfMonth:(int)year andMonth:(int)month {
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:1];
    [comp setMonth:month];
    [comp setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comp];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    return (int)[weekdayComponents weekday];
}

//判断是否为闰年
- (bool)is_LeapYear {
    if (self.year % 100 == 0) {
        if (self.year % 400 == 0) {
            return true;
        }
    }
    else if (self.year % 4 == 0) {
        return true;
    }
    return false;
}

//输出XXXX年XX月的月历
//格式问题：将中文“日 一 二 三 四 五 六”改为“Su Mo Tu We Th Fr Sa”
- (void)printMonth {
    NSArray *dayInMonth = [[NSArray alloc]
                               initWithObjects:@31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];
    NSArray *dayInMonthLeap = [[NSArray alloc]
                               initWithObjects:@31, @29, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];
    NSArray *monthInChinese = [[NSArray alloc]
                               initWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
                               @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
    NSMutableString *title = [[NSMutableString alloc]
                              initWithFormat:@"%@", [monthInChinese objectAtIndex:self.month-1]];
    [title appendString:@" "];
    [title appendFormat:@"%d", self.year];
    NSString *weekList = [[NSString alloc] initWithFormat:@"%@", @"Su Mo Tu We Th Fr Sa"];
    int spaceNum = (int)(weekList.length - title.length + 1) / 2;
    for (int i = 0; i < spaceNum; i++) {
        printf(" ");
    }
    printf("%s\n", [title UTF8String]);
    printf("%s\n", [weekList UTF8String]);
    for (int i = 1; i < self.weekday; i++) {
        printf("   ");
    }
    int tmp = self.weekday;
    if ([self is_LeapYear]) {
        for (int w = tmp, d = 1; d <= [[dayInMonthLeap objectAtIndex:self.month-1] intValue]; d++, w++) {
            printf("%2d ", d);
            if (w % 7 == 0) {
                printf("\n");
            }
        }
    }
    else {
        for (int w = tmp, d = 1; d <= [[dayInMonth objectAtIndex:self.month-1] intValue]; d++, w++) {
            printf("%2d ", d);
            if (w % 7 == 0) {
                printf("\n");
            }
        }
    }
    printf("\n");
}

//输出XXXX年的日历
- (void)printYear {
    NSString *titleYear = [[NSString alloc] initWithFormat:@"%d", self.year];
    NSString *titleWeekList = [[NSString alloc] initWithFormat:@"%@",
                               @"Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa"];
    int spaceNum = (int)(titleWeekList.length - titleYear.length + 1) / 2;
    for (int i = 0; i < spaceNum; i++) {
        printf(" ");
    }
    printf("%s\n", [titleYear UTF8String]);
    for (int i = 1; i <= 4; i++) {
        if (i == 1)
            printf("         一月                    二月                    三月\n");
        else if (i == 2)
            printf("\n         四月                    五月                    六月\n");
        else if (i == 3)
            printf("\n         七月                    八月                    九月\n");
        else
            printf("\n         十月                   十一月                   十二月\n");
        printf("%s\n", [titleWeekList UTF8String]);
        int weekday1 = [Date getWeekdayOfMonth:self.year andMonth:i*3-2];
        int weekday2 = [Date getWeekdayOfMonth:self.year andMonth:i*3-1];
        int weekday3 = [Date getWeekdayOfMonth:self.year andMonth:i*3];
        int day1, day2, day3;
        day1 = day2 = day3 = 1;
        //闰年
        NSArray *dayInMonth;
        if ([self is_LeapYear]) {
            dayInMonth = [[NSArray alloc]
                                   initWithObjects:@31, @29, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];
        }
        else {
            dayInMonth = [[NSArray alloc]
                                       initWithObjects:@31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];
        }
        
        while (day1 <= [[dayInMonth objectAtIndex:i*3-3] intValue] ||
            day2 <= [[dayInMonth objectAtIndex:i*3-2] intValue] ||
            day3 <= [[dayInMonth objectAtIndex:i*3-1] intValue]) {
            if (day1 > [[dayInMonth objectAtIndex:i*3-3] intValue])
                printf("   ");
            for (int j = 1;  j <= (weekday1-1) % 7; j++) {
                printf("   ");
            }
            for ( ; day1 <= [[dayInMonth objectAtIndex:i*3-3] intValue]; weekday1++) {
                printf("%2d ", day1++);
                if (weekday1 % 7 == 0 || day1 > [[dayInMonth objectAtIndex:i*3-3] intValue])
                    break;
            }
            while (day1 > [[dayInMonth objectAtIndex:i*3-3] intValue] && weekday1 % 7 != 0) {
                printf("   ");
                weekday1++;
            }
            weekday1++;
            printf("  ");
            if (day2 > [[dayInMonth objectAtIndex:i*3-2] intValue])
                printf("   ");
            for (int j = 1;  j <= (weekday2-1) % 7; j++) {
                printf("   ");
            }
            for ( ; day2 <= [[dayInMonth objectAtIndex:i*3-2] intValue]; weekday2++) {
                printf("%2d ", day2++);
                if (weekday2 % 7 == 0 || day2 > [[dayInMonth objectAtIndex:i*3-2] intValue])
                    break;
            }
            while (day2 > [[dayInMonth objectAtIndex:i*3-2] intValue] && weekday2 % 7 != 0) {
                printf("   ");
                weekday2++;
            }
            weekday2++;
            printf("  ");
            for (int j = 1; j <= (weekday3-1) % 7; j++) {
                printf("   ");
            }
            for ( ; day3 <= [[dayInMonth objectAtIndex:i*3-1] intValue]; weekday3++) {
                printf("%2d ", day3++);
                if (weekday3 % 7 == 0 || day3 > [[dayInMonth objectAtIndex:i*3-1] intValue])
                    break;
            }
            weekday3++;
            printf("\n");
        }
    }
}

@end

