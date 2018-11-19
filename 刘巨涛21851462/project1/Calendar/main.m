//
//  main.m
//  Calendar
//
//  Created by Jutao on 2018/10/22.
//  Copyright © 2018 Jutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "date.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Calendar *obj = [[Calendar alloc] init];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        int year = (int)[components year];
        int month = (int)[components month];
        
        if (argc != 1 && argc != 2 && argc != 3) {
            printf("command error.\n");
            [obj Print_usage];
        }
        else if (argc == 2) {
            year = atoi(argv[1]);
            if ([obj Check_year:year]) {
                [obj Print_year:year];
            }
            else {
                printf("year error.\n");
                [obj Print_usage];
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
            
            if ([obj Check_year:year]) {
                if ([obj Check_month:month]) {
                    [obj Print_month:year :month];
                }
                else {
                    printf("month error or paras error \"-m\".\n");
                    [obj Print_usage];
                }
            }
            else {
                printf("year error.\n");
                [obj Print_usage];
            }
        }
    }
    return 0;
}
