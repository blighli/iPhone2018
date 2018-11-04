//
//  Date.h
//  cal
//
//  Created by dxy on 2018/10/22.
//  Copyright © 2018年 dxy. All rights reserved.
//

#ifndef Date_h
#define Date_h

@interface Date: NSObject
{
    NSDate *date;
    NSCalendar *calendar;
    NSDateComponents *comps;
}

- (id)init;
- (NSInteger) getCurrentDay;
- (NSInteger) getCurrentMonth;
- (NSInteger) getCurrentYear;
- (NSInteger) getMonthFisrtDaysWeekday:(NSInteger)month andYear:(NSInteger)year;
- (NSInteger) getMonthLastDay:(NSInteger)month andYear:(NSInteger)year;

@end


#endif /* Date_h */
