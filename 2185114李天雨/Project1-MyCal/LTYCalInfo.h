//
//  LTYCalInfo.h
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYCalInfo : NSObject
+(int)getTheWeekOfDayByYear:(int)year
                 andByMonth:(int)month;

+ (int)getDaysInMonth:(int)year
                month:(int)imonth;
@end
