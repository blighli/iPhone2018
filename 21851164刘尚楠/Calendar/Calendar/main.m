//
//  main.m
//  Calendar
//
//  Created by Marveliu on 2018/10/16.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Calendar *obj = [[Calendar alloc] init];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        int month = (int)[components month];
        int year = (int)[components year];
        
        if (argc != 1 && argc != 2 && argc != 3) {
            printf("命令非法.\n");
            [obj printUsage];
        }
        else if (argc == 2) {
            // 2参数
            year = atoi(argv[1]);
            if ([obj checkYear:year]) {
                [obj printYear:year];
            }
            else {
                printf("年份非法.\n");
                [obj printUsage];
            }
        }
        else {
            // 3参数
            if (argc == 3) {
                if (strcmp(argv[1], "-m") == 0) {
                    month = atoi(argv[2]);
                }
                else {
                    month = atoi(argv[1]);
                    year = atoi(argv[2]);
                }
            }
            
            if ([obj checkYear:year]) {
                if ([obj checkMonth:month]) {
                    [obj printMonth:year :month];
                }
                else {
                    printf("月份非法或者参数错误 \"-m\".\n");
                    [obj printUsage];
                }
            }
            else {
                printf("年份非法.\n");
                [obj printUsage];
            }
        }
    }
    return 0;
}
