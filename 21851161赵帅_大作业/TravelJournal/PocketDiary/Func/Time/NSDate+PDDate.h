//
//  NSDate+PDDate.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PDDate)

- (NSInteger)yearValue;
- (NSInteger)monthValue;
- (NSInteger)dayValue;
- (NSInteger)weekdayValue;

- (NSDate *)beforeDays:(NSInteger)days;
- (NSDate *)afterDays:(NSInteger)days;
- (NSDate *)getSundayInThisWeek;

- (NSDate *)yesterday;
- (NSDate *)tomorrow;

@end
