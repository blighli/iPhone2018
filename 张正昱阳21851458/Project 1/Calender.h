//
//  Calender.h
//  Project 1
//
//  Created by 张正昱阳 on 18-12-13.
//  Copyright (c) 2018年 张正昱阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) fprintf(stderr,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface MonthCalendar:NSObject

@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger weekOfFirstDay;
@property (nonatomic) NSInteger daysCount;

- (instancetype)initWithYear:(NSInteger)year
                  usingMonth:(NSInteger)month;
- (void)printMonthCalendar;

+ (NSInteger)getDaysCounts:(NSInteger)month
                  fromYear:(NSInteger)year;
+ (NSArray *)monthNameArray;

@end

