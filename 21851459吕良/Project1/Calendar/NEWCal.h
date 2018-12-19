//
//  NEWCal.h
//  Calendar
//
//  Created by macos on 2018/10/18.
//  Copyright © 2018 macos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEWCal : NSObject

- (void) printMonth: (NSUInteger)month ofYear:(NSUInteger)year;
- (void) printYear: (NSUInteger)year;
@end

NS_ASSUME_NONNULL_END
