//
//  getCurrentMonthAndYear.m
//  calendar
//
//  Created by abby on 2018/10/22.
//  Copyright © 2018 abby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getCurrentMonthAndYear.h"

@implementation GetCurrentMonthAndYear

-(NSInteger) getCurrentYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentMonth = [components year];
    return currentMonth;
}

-(NSInteger) getCurrentMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [components month];
    return currentYear;
}

@end
