//
//  date.h
//  Calendar
//
//  Created by Jutao on 2018/10/22.
//  Copyright © 2018 Jutao. All rights reserved.
//

#ifndef date_h
#define date_h

@interface Calendar : NSObject
- (void) Print_usage;
- (bool) isLeapYear:(int)year;
- (int) countDays:(int)year :(int) month :(int)day;
- (int) getDayOfWeek:(int)year :(int)month :(int)day;
//打印年月
- (void) Print_year:(int)year;
- (void) Print_month:(int)year :(int)month;
- (void) Print_line:(int)year :(int)start :(int)end;
//格式检查
- (bool) Check_year:(int)year;
- (bool) Check_month:(int)month;
@end

#endif /* date_h */
