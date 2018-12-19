//
//  calendar.h
//  Calendar
//
//  Created by Marveliu on 2018/10/16.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#ifndef calendar_h
#define calendar_h

@interface Calendar : NSObject

// 使用说明
- (void) printUsage;

// 闰年等判定
- (bool) isLeapYear:(int)year;
- (int) countDays:(int)year :(int) month :(int)day;
- (int) getDayOfWeek:(int)year :(int)month :(int)day;

// 年月打印
- (void) printYear:(int)year;
- (void) printMonth:(int)year :(int)month;
- (void) printLine:(int)year :(int)start :(int)end;

// 格式检查
- (bool) checkYear:(int)year;
- (bool) checkMonth:(int)month;
@end


#endif /* calendar_h */



