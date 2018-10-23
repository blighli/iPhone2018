//
//  logCal.h
//  calendar
//
//  Created by abby on 2018/10/20.
//  Copyright © 2018 abby. All rights reserved.
//

#ifndef _cal_h
#define _cal_h

@interface LogCal : NSObject
-(NSInteger) weakDayForFirstDayOfMonth:(int)year :(int)month: (int)day;
-(void) logLine:(int)year :(int)startIndex :(int)endIndex;
-(void) logYear:(int)year;
-(void) logMonth:(NSInteger)year :(NSInteger)month;
-(void) logUsage;
@end

#endif /* logCal_h */
