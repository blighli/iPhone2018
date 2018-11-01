//
// Created by 汤凯凯 on 2018/10/14.
// Copyright (c) 2018 汤凯凯. All rights reserved.
//

#import "CalendarOfMonth.h"


@implementation CalendarOfMonth {

}
- (id)initWithStartWeekDay:(int)s totalDays:(int)t month:(int)m year:(int)y {
    self.startWeekday = s;
    self.totalDays = t;
    self.month = m;
    self.year = y;
    return self;
}

@end