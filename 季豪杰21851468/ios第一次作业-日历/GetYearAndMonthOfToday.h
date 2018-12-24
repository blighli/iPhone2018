//
//  GetYearAndMonthOfToday.h
//  calendar_jhj
//
//  Created by pc－jhj on 2018/10/23.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetYearAndMonthOfToday : NSObject
-(NSInteger) getYear:(NSDate *)date;
-(NSInteger) getMonth:(NSDate *)date;
-(NSInteger) getWeekday:(NSDate *)date;
-(NSInteger) getDaysInMonth:(NSInteger)year month:(NSInteger)month;
-(NSInteger) getDay:(NSDate *)date;
@end
