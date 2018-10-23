//
//  cal.h
//  cal
//
//  Created by HuaDream on 2018/10/13.
//  Copyright © 2018年 HuaDream. All rights reserved.
//

#ifndef cal_h
#define cal_h

@interface Cal : NSObject
{
    NSMutableArray *printer;
    NSArray *monthName;
    NSDateComponents *highlightingDay;
}

- (void) addMonthBlockWithMonth:(int) month andYear: (int) year;
- (void) addMonthBlockWithFirstDayInWeek:(int) firstDayInWeek andMonth:(int)month andYear:(int) year dayInMonth:(int)day;
- (void) print ;
- (void) printWithCol:(int)col;
- (id) initWithHighlightingDay:(NSDateComponents *) highlightingDay;
- (void) addMonthBlockWithMonthInterval:(int) interval andMonth:(int) month andYear: (int) year;

@end

#endif /* cal_h */
