//
//  MonthCalendar.h
//  Calendar
//
//  Created by ZJ on 2018/10/20.
//  Copyright © 2018 JZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) fprintf(stderr,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface MonthCalendar:NSObject

@property (nonatomic) NSInteger year;  //这个月的年份
@property (nonatomic) NSInteger month; //这个月的月份
@property (nonatomic) NSInteger weekOfFirstDay; //这个月第一天是周几
@property (nonatomic) NSInteger daysCount; //这个月有多少天

- (instancetype)initWithYear:(NSInteger)year
                  usingMonth:(NSInteger)month;
- (void)printMonthCalendar;

+ (NSInteger)getDaysCounts:(NSInteger)month
                  fromYear:(NSInteger)year;
+ (NSArray *)monthNameArray;

@end
