//
//  Calender.m
//  Project 1
//
//  Created by 张正昱阳 on 18-12-13.
//  Copyright (c) 2018年 张正昱阳. All rights reserved.
//

#import "Calender.h"

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
    NSLog(@"Sun Mon Tue Wen Thu Fri Sat\n");
    
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
    return @[@"January", @"February", @"March", @"April", @"May", @"June",@"July", @"August", @"September", @"October", @"November", @"December",];
}

@end

