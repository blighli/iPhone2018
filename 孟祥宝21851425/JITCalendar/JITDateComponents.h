//
//  JITDateComponents.h
//  JITCalendar
//
//  Created by JuicyITer on 13/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GREGORIAN 1
#define CHINESE 0
#define COUNT 50
#define NOOPTION @""
#define MAXDAYLENGTH 30
#define WEEKDAYS 7
#define WITHHEADER 1
#define WITHOUTHEADER 0
#define WITHYEAR 1
#define WITHOUTYEAR 0

NS_ASSUME_NONNULL_BEGIN

@interface JITDateComponents : NSDateComponents

+ (instancetype)newDateWithDay:(NSInteger)day
                         month:(NSInteger)month
                          year:(NSInteger)year;

+ (instancetype)newDateWithMonth:(NSInteger)month
                            year:(NSInteger)year;

+ (instancetype)newDateWithYear:(NSInteger)year;

+ (instancetype)newDateWithMonth:(NSInteger)month;

- (JITDateComponents *)today;

- (JITDateComponents *)convertToChinese;

@end

NS_ASSUME_NONNULL_END
