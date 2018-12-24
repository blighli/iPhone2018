//
//  PrintCal.h
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/23.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrintCal : NSObject
- (void)printCalendar:(int)month year:(int)year;
- (void)PrintCalendar:(int)year;
- (instancetype)init:(int)year;
@end

NS_ASSUME_NONNULL_END
