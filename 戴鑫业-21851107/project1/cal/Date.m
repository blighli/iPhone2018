//
//  Date.m
//  cal
//
//  Created by dxy on 2018/10/22.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"

@implementation Date
- (id)init{
    self = [super init];
    date = [NSDate date];
    calendar = [NSCalendar currentCalendar];
    return self;
}

- (NSInteger) getCurrentDay{
    comps = [calendar components:(NSCalendarUnitDay) fromDate:date];
    NSInteger day = [comps day];
    return day;
}

- (NSInteger) getCurrentYear{
    comps = [calendar components:(NSCalendarUnitYear) fromDate:date];
    NSInteger year = [comps year];
    return year;
}

- (NSInteger) getCurrentMonth{
    comps = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    NSInteger month = [comps month];
    return month;
}

- (NSInteger) getMonthFisrtDaysWeekday:(NSInteger)month andYear:(NSInteger)year{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",month,1,year];
    NSDate *firstDayDate = [formatter dateFromString:firstDay];
    comps = [calendar components:(NSCalendarUnitWeekday) fromDate:firstDayDate];
    NSInteger weekday = [comps weekday];
    return weekday;
}

- (NSInteger) getMonthLastDay:(NSInteger)month andYear:(NSInteger)year{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",month,1,year];
    NSDate *firstDayDate = [formatter dateFromString:firstDay];
    NSInteger monthNum = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDayDate].length;
    return monthNum;
}
@end
