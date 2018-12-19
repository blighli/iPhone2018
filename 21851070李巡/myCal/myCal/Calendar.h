//
//  Calendar.h
//  myCal
//
//  Created by 之川 on 2018/10/17.
//  Copyright © 2018 LX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calendar : NSObject

//print
-(void) print:(int)year :(int)month;
-(void) print:(int)year;
-(void) printHelp;

//check
-(bool) checkYear:(NSString *)year;
-(bool) checkMonth:(NSString *)month;
-(bool) isNum:(NSString *)str;

-(bool) isLeap:(int)year;
-(int) getDayOfWeek:(int)year :(int)month :(int)day;

@end

NS_ASSUME_NONNULL_END
