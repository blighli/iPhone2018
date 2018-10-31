//
//  DateHelper.h
//  Cal
//
//  Created by dawn on 2018/10/19.
//  Copyright © 2018 dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateHelper : NSObject {
    NSDateComponents *components;
}

-(int)getCurrentYear;
-(int)getCurrentMonth;
-(int)getCurrentDay;
-(int)getCurrentWeek;
-(int)getElapsedWeek:(int)year and:(int)month and:(int)day;
-(BOOL)isLegal:(int)year and:(int)month and:(int)day;

@end

NS_ASSUME_NONNULL_END
