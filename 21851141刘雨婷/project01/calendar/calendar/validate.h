//
//  validate.h
//  calendar
//
//  Created by abby on 2018/10/22.
//  Copyright © 2018 abby. All rights reserved.
//

#ifndef validate_h
#define validate_h
@interface Validate : NSObject
-(bool) isValidYear:(int)year;
-(bool) isValidMonth:(int)month;
-(bool) isLeapYear:(int)year;
@end

#endif /* validate_h */
