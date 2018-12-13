//
//  GetYearAndMonthOfToday.m
//  calendar_jhj
//
//  Created by pc－jhj on 2018/10/23.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import "GetYearAndMonthOfToday.h"

@implementation GetYearAndMonthOfToday
-(NSInteger) getYear:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger  calformat= NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay;
    NSDateComponents *componentsd  = [cal components:calformat fromDate:date];
    NSInteger year = [componentsd year];
    return year;
    
}

-(NSInteger) getMonth:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger  calformat= NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay;
    NSDateComponents *componentsd  = [cal components:calformat fromDate:date];
    NSInteger month = [componentsd month];
    return month;
}

-(NSInteger) getWeekday:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger  calformat= NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay;
    NSDateComponents *componentsd  = [cal components:calformat fromDate:date];
    NSInteger weekday = [componentsd weekday];
    return weekday;
}
-(NSInteger) getDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger  calformat= NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay;
    NSDateComponents *componentsd  = [cal components:calformat fromDate:date];
    NSInteger getday = [componentsd day];
    return getday;
}

-(NSInteger) getDaysInMonth:(NSInteger)year month:(NSInteger)month
{

    if((month == 0)||(month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
    
}



@end
