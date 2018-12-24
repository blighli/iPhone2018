//
//  cal.h
//  Project1
//
//  Created by Zhenyu Chen on 2018/10/11.
//  Copyright © 2018年 Zhenyu Chen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Cal : NSObject
- (bool) is_leap_year:(int)year;
- (int) count_days:(int)year :(int) month :(int)day;
- (int) get_the_day_of_the_week:(int)year :(int)month :(int)day;
- (void) print_year:(int)year;
- (void) print_month:(int)year :(int)month;
- (void) parallel_print:(int)year :(int)start :(int)end;
- (bool) check_year:(int)year;
- (bool) check_month:(int)month;
- (void) print_usage;
@end

