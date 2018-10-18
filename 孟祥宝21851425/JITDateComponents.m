//
//  JITDateComponents.m
//  JITCalendar
//
//  Created by JuicyITer on 13/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"

@implementation JITDateComponents

+ (instancetype)newDateWithDay:(NSInteger)day
                         month:(NSInteger)month
                          year:(NSInteger)year
{
    JITDateComponents *temp = [[JITDateComponents alloc] init];
    
    temp.day = day;
    temp.month = month;
    temp.year = year;
    temp.calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    return temp;
}

+ (instancetype)newDateWithMonth:(NSInteger)month
                            year:(NSInteger)year
{
    JITDateComponents *comps = [JITDateComponents newDateWithDay:1 month:month year:year];
    return comps;
}
+ (instancetype)newDateWithYear:(NSInteger)year
{
    JITDateComponents *comps = [JITDateComponents newDateWithMonth:1 year:year];
    return comps;
}

+ (instancetype)newDateWithMonth:(NSInteger)month
{
    JITDateComponents *temp = [JITDateComponents newDateWithYear:1970];
    JITDateComponents *comps = [temp today];
    comps.month = month;
    
    return comps;
}

- (JITDateComponents *)today
{
    NSDate *now = [NSDate date];
    JITDateComponents *comps = [[JITDateComponents alloc] init];
    comps.day = [self.calendar component:NSCalendarUnitDay
                                         fromDate:now];
    comps.month = [self.calendar component:NSCalendarUnitMonth
                                           fromDate:now];
    comps.year = [self.calendar component:NSCalendarUnitYear
                                          fromDate:now];
    comps.calendar = [NSCalendar autoupdatingCurrentCalendar];
    return comps;
}

- (JITDateComponents *)convertToChinese
{
    NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [gre dateFromComponents:self];
    
    gre = nil;
    NSCalendar *ch = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    enum NSCalendarUnit unitflag = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay;
    
    JITDateComponents *c = (JITDateComponents *)[ch components:unitflag
                                                      fromDate:date];
    c.calendar = ch;
    
    return c;
}

@end
