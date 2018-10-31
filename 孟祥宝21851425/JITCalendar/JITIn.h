//
//  JITIn.h
//  JITCalendar
//
//  Created by JuicyITer on 17/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITDateComponents.h"
#import "JITError.h"
#import "JITInteger.h"
#import "JITOut.h"

NS_ASSUME_NONNULL_BEGIN

@interface JITIn : JITDateComponents

+ (void)handleOption:(NSMutableArray *)argList;

+ (void)handleParameters:(NSMutableArray *)argList
              withOption:(NSInteger)op;
@end

NS_ASSUME_NONNULL_END
