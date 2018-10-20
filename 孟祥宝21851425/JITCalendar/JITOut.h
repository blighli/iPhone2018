//
//  JITOut.h
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"
#import "JITInteger.h"
#import "JITString.h"
#import "JITArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITOut : JITDateComponents

+ (void)gOneMonthOut:(JITDateComponents *)comps
          isWithYear:(NSInteger)iYear;

+ (void)cOneMonthOut:(JITDateComponents *)comps
          isWithYear:(NSInteger)iYear;

+ (void)gAdjacentMonthsOut:(JITDateComponents *)comps
              isWithHeader:(NSInteger)iHeader;

+ (void)cAdjacentMonthsOut:(JITDateComponents *)comps
              isWithHeader:(NSInteger)iHeader;

+ (void)gYearOut:(JITDateComponents *)comps;

+ (void)cYearOut:(JITDateComponents *)comps;

@end

NS_ASSUME_NONNULL_END
