//
//  DateHelper.m
//  Cal
//
//  Created by dawn on 2018/10/19.
//  Copyright © 2018 dawn. All rights reserved.
//

#define IS_LEAP_YEAR(y) (y % 4 == 0 && y % 100 != 0 || y % 400 == 0)

#import "DateHelper.h"

@implementation DateHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDate *currentData = [NSDate date];
        NSCalendar *calender = [NSCalendar currentCalendar];
        unsigned flags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
        components = [calender components:flags fromDate:currentData];
    }
    return self;
}

-(int)getCurrentYear {
    return (int)[components year];
}

-(int)getCurrentMonth {
    return (int)[components month];
}

-(int)getCurrentDay {
    return (int)[components day];
}


-(int)getCurrentWeek {
    return [self getElapsedWeek:[self getCurrentYear] and:[self getCurrentMonth] and:[self getCurrentDay]];
}

-(int)getElapsedWeek:(int)year and:(int)month and:(int)day {
    unsigned long totDays = 0;
    int dayPerMonth[12] = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int y = 1;
    int m = 0;
    while (!(y == year && m == month)) {
        if (m != 2) {
            totDays += dayPerMonth[m - 1];
        }
        else {
            if IS_LEAP_YEAR(y) {
                totDays += 29;
            }
            else {
                totDays += 28;
            }
        }
        if (m == 12) {
            y++;
            m = 1;
        }
        else {
            m++;
        }
    }
    totDays += day;
    return (totDays + 5) % 7 + 1;
}


-(BOOL)isLegal:(int)year and:(int)month and:(int)day {
    if (day <= 0 || day >= 32) {
        return false;
    }
    int max = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        max = 31;
    } else if(month == 4 || month == 6 || month == 9 || month == 11) {
        max = 30;
    } else {
        max = 28;
        if IS_LEAP_YEAR(year) {
            max++;
        }
    }
    return day <= max;
}

@end
