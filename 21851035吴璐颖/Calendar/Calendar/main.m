//
//  main.m
//  Calendar
//
//  Created by wuluying on 2018/10/22.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"
#import "CheckFormat.h"
#import "Date.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        int year, month;
        int day = 1;
        if (argc == 1) {
            //缺少参数
            [Error printError];
        }
        else if (argc == 2) {
            //input: cal
            NSString *argv1 = [[NSString alloc]
                               initWithCString:argv[1] encoding:NSASCIIStringEncoding];
            if ([CheckFormat is_Cal:argv1]) {
                //获取当前年月
                NSDate *currentDate = [NSDate date];
                NSCalendar *cal = [NSCalendar currentCalendar];
                unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
                NSDateComponents *d = [cal components:unitFlags fromDate:currentDate];
                year = (int)[d year];
                month = (int)[d month];
//                day = (int)[d day];
                Date *date = [[Date alloc] initWithYearMonthDay:year andMonth:month andDay:day];
                [date getWeekday];
                [date printMonth];
            }
            else {
                [Error printError];
            }
        }
        else if (argc == 3) {
            //input: cal 2018
            NSString *argv1 = [[NSString alloc]
                               initWithCString:argv[1] encoding:NSASCIIStringEncoding];
            NSString *argv2 = [[NSString alloc]
                               initWithCString:argv[2] encoding:NSASCIIStringEncoding];
            if ([CheckFormat is_Cal:argv1] && [CheckFormat is_Num:argv2]) {
                year = (int)[argv2 integerValue];
                month = 1;
                Date *date = [[Date alloc] initWithYearMonthDay:year andMonth:month andDay:day];
                [date printYear];
            }
            else {
                [Error printError];
            }
        }
        else if (argc == 4) {
            //input: cal 10 2018
            //input: cal -m 10
            NSString *argv1 = [[NSString alloc]
                               initWithCString:argv[1] encoding:NSASCIIStringEncoding];
            NSString *argv2 = [[NSString alloc]
                               initWithCString:argv[2] encoding:NSASCIIStringEncoding];
            NSString *argv3 = [[NSString alloc]
                               initWithCString:argv[3] encoding:NSASCIIStringEncoding];
            if ([CheckFormat is_Cal:argv1] && [CheckFormat is_Month:argv2] && [CheckFormat is_Num:argv3]) {
                year = (int)[argv3 integerValue];
                month = (int)[argv2 integerValue];
                Date *date = [[Date alloc] initWithYearMonthDay:year andMonth:month andDay:day];
                [date getWeekday];
                [date printMonth];
            }
            else if ([CheckFormat is_Cal:argv1] && [CheckFormat is_M:argv2] && [CheckFormat is_Month:argv3]) {
                NSDate *currentDate = [NSDate date];
                NSCalendar *cal = [NSCalendar currentCalendar];
                unsigned int unitFlags = NSCalendarUnitYear;
                NSDateComponents *d = [cal components:unitFlags fromDate:currentDate];
                year = (int)[d year];
                month = (int)[argv3 integerValue];
                Date *date = [[Date alloc] initWithYearMonthDay:year andMonth:month andDay:day];
                [date getWeekday];
                [date printMonth];
            }
            else {
                [Error printError];
            }
        }
    }
    return 0;
}
