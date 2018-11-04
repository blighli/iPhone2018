//
// Created by 汤凯凯 on 2018/10/14.
// Copyright (c) 2018 汤凯凯. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalendarOfMonth : NSObject

@property(assign, nonatomic) int startWeekday;
@property(assign, nonatomic) int totalDays;
@property(assign, nonatomic) int month;
@property(assign, nonatomic) int year;

- (id)initWithStartWeekDay:(int)s totalDays:(int)t month:(int)m year:(int)y;
@end