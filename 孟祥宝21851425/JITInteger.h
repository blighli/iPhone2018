//
//  JITDateOut.h
//  JITCalendar
//
//  Created by JuicyITer on 13/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"
#import "JITString.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITInteger : JITDateComponents

+ (NSInteger)stringLength:(NSString *)str;

+ (NSInteger)numberFromString:(NSString *)str;

+ (NSInteger)maxLengthInStrings:(NSMutableArray *)arr;

+ (NSInteger)getWeekdayIndexFromComponents:(JITDateComponents *)comps;
+ (NSInteger)getLine:(NSInteger)index;
+ (NSInteger)isLastInWeek:(NSInteger)index;
+ (NSInteger)maxWidthOfString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
