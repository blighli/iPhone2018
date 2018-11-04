//
//  YearMonthDay.h
//  ZSCalendarTest
//
//  Created by 赵帅 on 2018/10/16.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YearMonthDay : NSObject

@property(nonatomic) int year;
@property(nonatomic) int month;
@property(nonatomic) int day;
@property(nonatomic) int thisYear;
@property(nonatomic) int thisMonth;
@property(nonatomic) int today;
@property(nonatomic) int weekday;

- (id)getYearMonth:(int)year Month:(int)month;
- (void)currentYearMonth;
- (NSInteger) getWeekDay;
- (bool) isLeapYear;
- (int) getMonthDaysNum;
-(NSMutableString *) transformMonthName;

@end

