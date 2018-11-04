//
//  PrintCalendar.h
//  ZSCalendarTest
//
//  Created by 赵帅 on 2018/10/16.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearMonthDay.h"
@interface PrintCalendar : NSObject

-(void) printMonth:(YearMonthDay*) monthCal;
-(void) printYear:(YearMonthDay*) yearCal;

@end
