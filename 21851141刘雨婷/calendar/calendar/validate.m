//
//  validate.m
//  calendar
//
//  Created by abby on 2018/10/22.
//  Copyright © 2018 abby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "validate.h"

@implementation Validate

-(bool) isValidYear:(int)year {
    return year > 0 && year < 10000;
}

-(bool) isValidMonth:(int)month {
    return month > 0 && month < 13;
}

- (bool) isLeapYear:(int)year {
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
        return 1;
    } else {
        return 0;
    }
}

@end
