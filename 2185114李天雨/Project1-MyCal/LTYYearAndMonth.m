//
//  LTYYearAndMonth.m
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import "LTYYearAndMonth.h"

@implementation LTYYearAndMonth

- (void) dateNow
{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //格式化
    unsigned int formate = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *d = [cal components:formate fromDate:date];
    
    _yearNow = (int)[d year];
    _monthNow = (int)[d month];
    
}
- (void) setYear:(int)year andMonth:(int)month
{
    _yearNow = year;
    _monthNow = month;
}

@end
