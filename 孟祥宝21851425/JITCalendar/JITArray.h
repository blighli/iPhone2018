//
//  JITArray.h
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"
#import "JITInteger.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITArray : JITDateComponents

+ (void)gOneMonthArray:(NSMutableArray *)arr
              inComps:(JITDateComponents *)comps
            isWithYear:(NSInteger)iYear;

+ (void)cOneMonthArray:(NSMutableArray *)arr
               inComps:(JITDateComponents *)comps
            isWithYear:(NSInteger)iYear;
+ (void)beautifyArray:(NSMutableArray *)arr
              inComps:(JITDateComponents *)comps
            withStyle:(NSInteger)style;

+ (void)gAdjacentMonthArray:(NSMutableArray *)arr
                    inComps:(JITDateComponents *)comps
                 isWithYear:(NSInteger)iYear;


+ (void)cAdjacentMonthArray:(NSMutableArray *)arr
                    inComps:(JITDateComponents *)comps
                 isWithYear:(NSInteger)iYear;
@end

NS_ASSUME_NONNULL_END
