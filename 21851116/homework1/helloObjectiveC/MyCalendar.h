//
//  Header.h
//  helloObjectiveC
//
//  Created by 张若静 on 2018/10/24.
//  Copyright © 2018年 zhangruojing. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
{
    NSArray *monthArray;
    int currentYear;
    int currentMonth;
}
-(bool)isLeapYear:(int)year;
- (int) calWeekday: (int)year andMonth:(int) month;
- (void) printWeekday;
- (int) calDay:(int) month andYear:(int) year;
- (void) printCarlendar:(int) year andMonth:(int) month;
- (void) printNextline;
- (void) initMonthArrayAndData;
- (int) currentYear;
- (int) currentMonth;
@end

