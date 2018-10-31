//
//  Cal.h
//  cal
//
//  Created by dxy on 2018/10/23.
//  Copyright © 2018年 dxy. All rights reserved.
//

#ifndef Cal_h
#define Cal_h

@interface Cal: NSObject
{
    Date *date;
    NSArray *MONTH_MAP;
}

-(bool)validateMonth:(const char*)cmonth;
-(bool)validateYear:(const char*)cyear;
-(void)printMonthLine:(NSInteger)month andYear:(NSInteger)year andLine:(NSInteger)line;
-(void)printCal:(NSInteger)month andYear:(NSInteger)year;
-(void)printYearCal:(NSInteger)year;

@end

#endif /* Cal_h */
