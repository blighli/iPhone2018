//
//  Day.m
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#import "Day.h"

@implementation Day

-(id)initWithYMD:(int)Y :(int)M :(int)D{
    _year=Y;
    _day=D;
    _month=M;
    NSDateComponents* comp=[NSDateComponents new];
    [comp setMonth:M];
    [comp setYear:Y];
    [comp setDay:D];
    NSCalendar* myCal=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    _myNSDate=[myCal dateFromComponents:comp];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    _myComp = [myCal components:unitFlags fromDate:_myNSDate];
    return self;
}
-(NSDate*) getDate{
    return _myNSDate;
}

-(int) getWeek{
    return [_myComp weekday];
}

-(bool) isRun{
    int t_year=_year;
    if ((t_year %4==0 && t_year %100 !=0) || t_year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
//获取这个月的天数
-(int) getMonthNum{
    switch (_month) {
        case 1:
            return 31;
            break;
        case 2:
            if([self isRun])
                return 29;
            return 28;
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}
-(NSMutableString *) getMonthInEnglish{
    int month=_month;
    switch (month) {
        case  1:
            return [[NSMutableString alloc] initWithFormat:@"January"];
            break;
        case  2:
            return [[NSMutableString alloc] initWithFormat:@"February"];
            break;
        case  3:
            return [[NSMutableString alloc] initWithFormat:@"March"];
            break;
        case  4:
            return [[NSMutableString alloc] initWithFormat:@"April"];
            break;
        case  5:
            return [[NSMutableString alloc] initWithFormat:@"May"];
            break;
        case  6:
            return [[NSMutableString alloc] initWithFormat:@"June"];
            break;
        case  7:
            return [[NSMutableString alloc] initWithFormat:@"July"];
            break;
        case  8:
            return [[NSMutableString alloc] initWithFormat:@"August"];
            break;
        case  9:
            return [[NSMutableString alloc] initWithFormat:@"September"];
            break;
        case  10:
            return [[NSMutableString alloc] initWithFormat:@"October"];
            break;
        case  11:
            return [[NSMutableString alloc] initWithFormat:@"November"];
            break;
        case  12:
            return [[NSMutableString alloc] initWithFormat:@"December"];
            break;
        default:
            break;
    }
    return [[NSMutableString alloc] initWithFormat:@""];;
}

@end
