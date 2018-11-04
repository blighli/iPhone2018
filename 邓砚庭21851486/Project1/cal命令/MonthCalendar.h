//
//  NSObject+Calendar.h
//  cal命令
//
//  Created by 邓砚庭 on 2018/10/23.
//  Copyright © 2018 邓砚庭21851486. All rights reserved.

#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) fprintf(stderr,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface MonthCalendar : NSObject

@property (nonatomic) NSInteger year;  //这个月的年份
@property (nonatomic) NSInteger month; //这个月份
@property (nonatomic) NSInteger weekOfFirstDay; //这个月第一天是周几
@property (nonatomic) NSInteger daysCount; //这个月有多少天

- (instancetype)initWithYear:(NSInteger)year
                  usingMonth:(NSInteger)month;
- (void)printMonthCalendar;

+ (NSInteger)getDaysCounts:(NSInteger)month
                  fromYear:(NSInteger)year;
+ (NSArray *)monthNameArray;

@end
