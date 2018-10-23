//
//  main.m
//  cal
//
//  Created by HuaDream on 2018/10/13.
//  Copyright © 2018年 HuaDream. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cal.h"

void printUsage () {
    printf("Usage: cal [-h] [-c col] [[month] year]\r\n"
           "       cal [-h] [-c col] [-m month] [year]\r\n"
           "Options:\r\n"
           "        -m month    Display the specified month.\r\n"
           "        -h          Turns off highlighting of today.\r\n"
           "        -c col      Display the year with `col` columns per row.\r\n"
           "        -H          Help\r\n"
           );
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char ch;
        int flag_year = 0;
        int flag_month = 0;
        int flag_col = 3;
        int flag_h = 1;
        
        while ((ch = getopt(argc, argv, "m:Hhc:")) != -1)
            switch (ch) {
                case 'm':
                    flag_month = atoi(optarg);
                    if (flag_month > 12 || flag_month < 1) {
                        printf("Error: month(-m) must between 1 and 12!\r\n");
                        printUsage();
                        return 0;
                    }
                    break;
                case 'c':
                    flag_col = atoi(optarg);
                    if (flag_col > 6 || flag_col < 1) {
                        printf("Error: col(-c) must between 1 and 6!\r\n");
                        printUsage();
                        return 0;
                    }
                    break;
                case 'h':
                    flag_h = 0;
                    break;
                case 'H':
                default:
                    printUsage();
                    return 0;
            }
        localeconv();

        argc -= optind;
        argv += optind;
        
        if (argc == 1) {
            flag_year = atoi(*argv++);
            if (flag_year < 1 || flag_year > 9999)
            {
                printf("Error: year must between 1 and 9999!\r\n");
                printUsage();
                return 0;
            }
        } else if (argc == 2) {
            flag_month = atoi(*argv++);
            flag_year = atoi(*argv++);
            if (flag_year < 1 || flag_year > 9999)
            {
                printf("Error: year must between 1 and 9999!\r\n");
                printUsage();
                return 0;
            }
            if (flag_month < 1 || flag_month > 12)
            {
                printf("Error: month must between 1 and 12!\r\n");
                printUsage();
                return 0;
            }
        }
        
        NSDateComponents *now = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:[NSDate date]];
        
        Cal *c;
        if (flag_h == 1) {
            c = [[Cal alloc] initWithHighlightingDay: now];
        } else {
            c = [[Cal alloc] init];
        }
    
        if (flag_year != 0) {
            if (flag_month == 0){
                for (int i = 1; i <= 12; i++) {
                    [c addMonthBlock:i inYear:flag_year];
                }
            } else {
                [c addMonthBlock:flag_month inYear:flag_year];
            }
        } else
        {
            if (flag_month == 0) {
                [c addMonthBlock:(int)[now month] inYear:(int)[now year]];
            } else {
                [c addMonthBlock:flag_month inYear:(int)[now year]];
            }
        }
        [c printWithCol: flag_col];
    }
    return 0;
}
