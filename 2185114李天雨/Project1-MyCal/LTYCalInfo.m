//
//  LTYCalInfo.m
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import "LTYCalInfo.h"

@implementation LTYCalInfo

//计算一个月的第一天是星期几 使用Kim larsson公式
+(int)getTheWeekOfDayByYear:(int)year
                 andByMonth:(int)month
{
    //Kim larsson
    int weekday = -1;
    
    if(month == 1 || month == 2){
        year = year -1;
        month = 12 + month;
        weekday = (1+2*month+3*(month+1)/5+year+year/4-year/100+year/400+1)%7;
    }
    else{
        weekday = (1+2*month+3*(month+1)/5+year+year/4-year/100+year/400+1)%7;
    }
 
    return weekday;
}

//计算一个月有多少天
+ (int)getDaysInMonth:(int)year
                month:(int)imonth
{
    // imonth == 0的情况是应对在CourseViewController里month-1的情况
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
    return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
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
