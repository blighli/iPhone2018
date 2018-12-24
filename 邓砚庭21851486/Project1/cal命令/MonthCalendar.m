//
//  NSObject+Calendar.m
//  cal命令
//
//  Created by 邓砚庭 on 2018/10/23.
//  Copyright © 2018 邓砚庭21851486. All rights reserved.
//

#import "MonthCalendar.h"

@implementation MonthCalendar

- (instancetype)initWithYear:(NSInteger)year
                  usingMonth:(NSInteger)month {
    self = [super init];
    if(self) {
        self.year = year;
        self.month = month;
        self.daysCount = [MonthCalendar getDaysCounts:self.month fromYear:self.year];
        
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:1];
        [dateComps setMonth:self.month];
        [dateComps setYear:self.year];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *date = [gregorian dateFromComponents:dateComps];
        //NSLog(@"%@", date);
        NSDateComponents *weekDayComps = [gregorian components:NSCalendarUnitWeekday fromDate:date];
        self.weekOfFirstDay = [weekDayComps weekday];
    }
    return self;
}

- (void)printMonthCalendar {
    NSArray *array = [MonthCalendar monthNameArray];
    NSString *monthName = [NSString stringWithFormat:@"      %@",
                           [array objectAtIndex:self.month - 1]];
    NSLog(@"%@ %ld\n", monthName, self.year);
    NSLog(@"日 一 二 三 四 五 六\n");
    
    for(int i = 1; i < self.weekOfFirstDay; i++) {
        NSLog(@"   ");
    }
    
    NSInteger nowWeek = self.weekOfFirstDay;
    for(int i = 1; i <= self.daysCount; i++) {
        NSLog(@"%2d", i);
        if(nowWeek >= 7) {
            nowWeek = 1;
            NSLog(@"\n");
        } else {
            nowWeek++;
            NSLog(@" ");
        }
    }
    NSLog(@"\n");
}

+ (NSInteger)getDaysCounts:(NSInteger)month
                  fromYear:(NSInteger)year{
    if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
        return 31;
    else if(month == 4 || month == 6 || month == 9 || month == 11)
        return 30;
    else if(year % 100 == 0) {
        if(year % 400 == 0)
            return 29;
        else return 28;
    }
    else {
        if(year % 4 == 0)
            return 29;
        else return 28;
    }
}

+ (NSArray *)monthNameArray{
    return @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
             @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月",];
}

@end
