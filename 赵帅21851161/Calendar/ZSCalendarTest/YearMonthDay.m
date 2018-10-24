//
//  YearMonthDay.m
//  ZSCalendarTest
//
//  Created by 赵帅 on 2018/10/16.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "YearMonthDay.h"

@implementation YearMonthDay

-(id)getYearMonth:(int)year Month:(int)month{
    _year=year;
    _month=month;
    return self;
}

- (void)currentYearMonth{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    //这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    NSDateComponents *d = [cal components:unitFlags fromDate:date];    
    _thisYear = (int)[d year];
    _thisMonth = (int)[d month];
}

-(NSInteger) getWeekDay{
    NSDateComponents* comp=[NSDateComponents new];
    [comp setYear:_year];
    [comp setMonth:_month];
    NSCalendar* cal=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * _Nullable date=[cal dateFromComponents:comp];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *components = [cal components:unitFlags fromDate:date];
    return [components weekday];
}

-(bool) isLeapYear{
    int t_year=_year;
    if ((t_year %4==0 && t_year %100 !=0) || t_year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

-(int) getMonthDaysNum{
    switch (_month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
            break;
        case 4: case 6: case 9: case 11:
            return 30;
            break;
        case 2:
            if ([self isLeapYear])
                return 29;
            return 28;
            break;
        default:
            return 0;
            break;
    }
}

-(NSMutableString *) transformMonthName{
    int month=_month;
    switch (month) {
        case  1:
            return [[NSMutableString alloc] initWithFormat:@"一月"];
            break;
        case  2:
            return [[NSMutableString alloc] initWithFormat:@"二月"];
            break;
        case  3:
            return [[NSMutableString alloc] initWithFormat:@"三月"];
            break;
        case  4:
            return [[NSMutableString alloc] initWithFormat:@"四月"];
            break;
        case  5:
            return [[NSMutableString alloc] initWithFormat:@"五月"];
            break;
        case  6:
            return [[NSMutableString alloc] initWithFormat:@"六月"];
            break;
        case  7:
            return [[NSMutableString alloc] initWithFormat:@"七月"];
            break;
        case  8:
            return [[NSMutableString alloc] initWithFormat:@"八月"];
            break;
        case  9:
            return [[NSMutableString alloc] initWithFormat:@"九月"];
            break;
        case  10:
            return [[NSMutableString alloc] initWithFormat:@"十月"];
            break;
        case  11:
            return [[NSMutableString alloc] initWithFormat:@"十一月"];
            break;
        case  12:
            return [[NSMutableString alloc] initWithFormat:@"十二月"];
            break;
    }
    return [[NSMutableString alloc] initWithFormat:@""];;
}

@end
