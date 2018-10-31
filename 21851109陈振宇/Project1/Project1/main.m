//
//  main.m
//  Project1
//
//  Created by Zhenyu Chen on 2018/10/11.
//  Copyright © 2018年 Zhenyu Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Cal *obj = [[Cal alloc] init];
        // reference: https://stackoverflow.com/questions/3694867/nsdate-get-year-month-day
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        int month = (int)[components month];
        int year = (int)[components year];
        
        if (argc != 1 && argc != 2 && argc != 3) {
            printf("Invalid command.\n");
            [obj print_usage];
        }
        else if (argc == 2) {
            year = atoi(argv[1]);
            if ([obj check_year:year]) {
                [obj print_year:year];
            }
            else {
                printf("Invalid year.\n");
                [obj print_usage];
            }
        }
        else {
            if (argc == 3) {
                if (strcmp(argv[1], "-m") == 0) {
                    month = atoi(argv[2]);
                }
                else {
                    month = atoi(argv[1]);
                    year = atoi(argv[2]);
                }
            }
            if ([obj check_year:year]) {
                if ([obj check_month:month]) {
                    [obj print_month:year :month];
                }
                else {
                    printf("Invalid month or second option is not \"-m\".\n");
                    [obj print_usage];
                }
            }
            else {
                printf("Invalid year.\n");
                [obj print_usage];
            }
        }
    }
    return 0;
}


