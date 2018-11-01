//
//  YearAndMonthNow.m
//  CalendarSMC
//
//  Created by 史梦辰 on 2018/10/25.
//  Copyright © 2018年 史梦辰. All rights reserved.
//
/*获取当前的年份和月份*/
#import "YearAndMonthNow.h"

@implementation YearAndMonthNow

-(void) yearAndMonth{

     NSDate *date = [NSDate date];
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    _yearNow=(int)[components year];
    _monthNow=(int)[components month];
  
}

@end
