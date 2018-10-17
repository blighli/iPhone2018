//
//  main.m
//  Calendar
//
//  Created by 徐超 on 2018/10/11.
//  Copyright © 2018 徐超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCCalendar.h"
#import "XCUtilities.h"

#define NSLog(FORMAT, ...)  printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //  没有额外参数
        if (argc == 1) {
            [XCCalendar printCalendarOfCurrentMonth];
        }
        //  有一个额外参数，表示年份，取值范围1..9999
        else if (argc == 2) {
            NSString *yearStr = [NSString stringWithUTF8String:argv[1]];
            if ([XCUtilities isPureInt:yearStr]) {
                NSInteger year = [yearStr intValue];
                if (year >= 1 && year <= 9999) {
                    [XCCalendar printCalendarOfYear:year];
                }
                else {
                    NSLog(@"Calendar: year `%@' not in range 1..9999", yearStr);
                }
            }
            else {
                NSLog(@"Calendar: year `%@' not in range 1..9999", yearStr);
            }
        }
        //  有两个额外参数
        else if (argc == 3) {
            //  第一个额外参数为“-m”，第二个参数表示月份，取值d范围1..12
            if ([[NSString stringWithUTF8String:argv[1]] isEqualToString:@"-m"]) {
                NSString *monthStr = [NSString stringWithUTF8String:argv[2]];
                if ([XCUtilities isPureInt:monthStr]) {
                    NSInteger month = [monthStr intValue];
                    if (month >= 1 && month <= 12) {
                        [XCCalendar printCalendarOfThisYearsMonth:month];
                    }
                    else {
                        NSLog(@"Calendar: %@ is neither a month number (1..12) nor a name", monthStr);
                    }
                }
                else {
                    NSLog(@"Calendar: %@ is neither a month number (1..12) nor a name", monthStr);
                }
            }
            //  第一个参数表示月份，取值d范围1..12，第二个参数表示年份，取值范围1..9999
            else {
                NSString *monthStr = [NSString stringWithUTF8String:argv[1]];
                if ([XCUtilities isPureInt:monthStr]) {
                    NSInteger month = [monthStr intValue];
                    if (month >= 1 && month <= 12) {
                        NSString *yearStr = [NSString stringWithUTF8String:argv[2]];
                        if ([XCUtilities isPureInt:yearStr]) {
                            NSInteger year = [yearStr intValue];
                            if (year >= 1 && year <= 9999) {
                                [XCCalendar printCalendarOfMonth:month inYear:year];
                            }
                            else {
                                NSLog(@"Calendar: year `%@' not in range 1..9999", yearStr);
                            }
                        }
                        else {
                            NSLog(@"Calendar: year `%@' not in range 1..9999", yearStr);
                        }
                    }
                    else {
                        NSLog(@"Calendar: %@ is neither a month number (1..12) nor a name", monthStr);
                    }
                }
                else {
                    NSLog(@"Parameter Error！！！");
                    NSLog(@"Usage: month year\t(e.g. 1 1970)\n       year\t\t(e.g. 1970)\n       -m month\t\t(e.g. -m 1)");
                }
            }
        }
        //  额外参数数量超过两个
        else {
            NSLog(@"Parameter Error！！！");
            NSLog(@"Usage: month year\n       year\n       -m month");
        }
    }
    return 0;
}
