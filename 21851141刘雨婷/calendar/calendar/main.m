//
//  main.m
//  calendar
//
//  Created by abby on 2018/10/20.
//  Copyright © 2018 abby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "logCal.h"
#import "validate.h"
#import "getCurrentMonthAndYear.h"
#import "formatMonth.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LogCal *calendar = [[LogCal alloc] init];
        GetCurrentMonthAndYear *myGetCurrentMonthAndYear = [[GetCurrentMonthAndYear alloc] init];
        Validate *myValidate = [[Validate alloc] init];
        if (argc == 1) {
            //参数只有cal,输出当前的年月日历
            NSInteger year = [myGetCurrentMonthAndYear getCurrentYear];
            NSInteger month = [myGetCurrentMonthAndYear getCurrentMonth];
            [calendar logMonth:year :month];
        }else if (argc == 2) {
            //参数只有cal 2018,输出当前的日历
            int year = atoi(argv[1]);
            if([myValidate isValidYear:year]) {
                [calendar logYear:year];
            } else {
                printf("cal: please input valid year and month\n");
                printf("cal: year in range 1..9999\n");
                [calendar logUsage];
            }
        }else if (argc == 3) {
            int month, year;
            //参数为cal -m 10输出当年10月；参数为cal 10 2018输出2018年10月
            if (strcmp(argv[1], "-m") == 0) {
                month = atoi(argv[2]);
                year = [myGetCurrentMonthAndYear getCurrentYear];
            }
            else {
                month = atoi(argv[1]);
                year = atoi(argv[2]);
            }
            if([myValidate isValidYear:year] && [myValidate isValidMonth:month]) {
                [calendar logMonth:year :month];
            } else {
                printf("cal: please input valid year and month\n");
                printf("cal: year in range 1..9999\n");
                printf("cal: month in range 1..12\n");
                [calendar logUsage];
            }
        }
    }
    return 0;
}
