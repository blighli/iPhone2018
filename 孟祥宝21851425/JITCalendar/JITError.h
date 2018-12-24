//
//  JITError.h
//  JITCalendar
//
//  Created by JuicyITer on 17/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITError : JITDateComponents

+ (void)illegalOption:(NSString *)op;

+ (void)illegalMonth:(NSString *)month;

+ (void)illegalYear:(NSString *)year;

+ (void)illegalUsage;

+ (void)requireArgument;

@end

NS_ASSUME_NONNULL_END
