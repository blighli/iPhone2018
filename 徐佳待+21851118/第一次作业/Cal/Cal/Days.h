//
//  Day.h
//
//  Created by xujiadai on 18/10/24.
//  Copyright © 2018年 xujiadai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Days : NSObject


+ (BOOL)isLeapYear:(int)year;

+ (int)daysOfUntilLastYear:(int)year;

+ (int)daysOfUntilLastMonth:(int)year yue:(int)yue;

@end
