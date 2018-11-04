//
//  JITString.h
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"
#import "JITInteger.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITString : JITDateComponents

+ (NSString *)gStringFromArray:(NSMutableArray *)arr
             inComps:(JITDateComponents *)comps;

+ (NSString *)cStringFromArray:(NSMutableArray *)arr
              inComps:(JITDateComponents *)comps;

+ (NSString *)beautifyString:(NSString *)str
                     withDay:(NSInteger)day
                     inComps:(JITDateComponents *)comps
                   withStyle:(NSInteger)op;

+ (NSString *)insertString:(NSString *)origin
                withString:(NSString *)str
                   atIndex:(NSInteger)index;

+ (NSString *)centerString:(NSString *)str
                 withWidth:(NSInteger)width;

+ (NSString *)formStringFromArray:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
