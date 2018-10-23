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

- (void) addMonthBlock:(int) month inYear: (int) year;
- (void) addMonthBlock:(int) firstDayInWeek withMonth:(int)month withYear:(int) year dayInMonth:(int)day;
- (void) print ;
- (void) printWithCol:(int)col;
- (id) initWithHighlightingDay:(NSDateComponents *) highlightingDay;

@end

#endif /* cal_h */
