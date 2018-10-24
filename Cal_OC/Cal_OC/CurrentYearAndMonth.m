//
//  CurrentYearAndMonth.m
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/24.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "CurrentYearAndMonth.h"

@implementation CurrentYearAndMonth

-(instancetype)init{
    self = [super init];
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    NSDateComponents *currentDate = [cal components:unitFlags fromDate:date];
    
    _year = (int)[currentDate year];
    _month = (int)[currentDate month];
    return self;
}

@end
