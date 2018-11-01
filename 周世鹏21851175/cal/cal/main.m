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
    printf("Usage: cal [-3hy] [-A number] [-B number] [-c col] [[month] year]\r\n"
           "       cal [-3h] [-A number] [-B number] [-c col] [-m month] [year]\r\n"
           "Options:\r\n"
           "        -m month    Display the specified month.\r\n"
           "        -h          Turns off highlighting of today.\r\n"
           "        -c col      Display the year with `col` columns per row.\r\n"
           "        -3          Display the previous, current and next month surrounding today.\r\n"
           "        -A number   Display the number of months after the current month.\r\n"
           "        -B number   Display the number of months before the current month.\r\n"
           "        -H          Help\r\n"
           );
}
void showError (char * error) {
    printf("Error: %s\r\n", error);
    printUsage();
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char ch;
        int flag_year = 0;
        int flag_month = 0;
        int flag_col = 3;
        int flag_h = 1;
        int flag_3 = 0;
        int flag_showYear = 0;
        int flag_before = 0;
        int flag_after = 0;
        
        while ((ch = getopt(argc, argv, "3m:Hhc:A:B:y")) != -1)
            switch (ch) {
                case '3':
                    flag_3 = 1;
                    break;
                case 'm':
                    flag_month = atoi(optarg);
                    if (flag_month > 12 || flag_month < 1) {
                        showError("month(-m) must between 1 and 12!");
                        return 0;
                    }
                    break;
                case 'c':
                    flag_col = atoi(optarg);
                    if (flag_col > 6 || flag_col < 1) {
                        showError("col(-c) must between 1 and 6!");
                        return 0;
                    }
                    break;
                case 'h':
                    flag_h = 0;
                    break;
                case 'A':
                    flag_after = atoi(optarg);
                    if (flag_after < 1) {
                        showError("Argument to -A must be positive");
                        return 0;
                    }
                    break;
                case 'B':
                    flag_before = atoi(optarg);
                    if (flag_before < 1) {
                        showError("Argument to -B must be positive");
                        return 0;
                    }
                    break;
                case 'y':
                    flag_showYear = 1;
                    break;
                case 'H':
                default:
                    printUsage();
                    return 0;
            }
        localeconv();
        if (flag_month != 0 && flag_showYear) {
            showError("-y together with -m is not supported.");
            return 0;
        }
        if (flag_3 && (flag_after || flag_before)) {
            showError("-3 together with -A and -B is not supported.");
            return 0;
        }
        if (flag_3 && flag_showYear) {
            showError("-3 together with -y is not supported.");
            return 0;
        }
        argc -= optind;
        argv += optind;
        
        if (argc == 1) {
            flag_year = atoi(*argv++);
            if (flag_year < 1 || flag_year > 9999)
            {
                showError("year must between 1 and 9999!");
                return 0;
            }
        } else if (argc == 2) {
            flag_month = atoi(*argv++);
            flag_year = atoi(*argv++);
            if (flag_year < 1 || flag_year > 9999)
            {
                showError("year must between 1 and 9999!");
                return 0;
            }
            if (flag_month < 1 || flag_month > 12)
            {
                showError("month must between 1 and 12!");
                return 0;
            }
        } else if (argc > 2){
            showError("argument error!");
            return 0;
        }
        if (flag_3 && flag_year != 0 && flag_month == 0) {
            showError("-3 together with a given year but no given month is not supported.");
            return 0;
        }
        
        NSDateComponents *now = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if (flag_showYear && !flag_year) {
            flag_year = (int)[now year];
        }
        
        Cal *c;
        if (flag_h == 1) {
            c = [[Cal alloc] initWithHighlightingDay: now];
        } else {
            c = [[Cal alloc] init];
        }
    
        if (flag_year != 0 || flag_showYear) {
            if (flag_month == 0){
                for (int i = 1; i <= 12; i++) {
                    [c addMonthBlockWithMonth:i andYear:flag_year];
                }
            } else {
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:-1 andMonth:flag_month andYear:flag_year];
                for (int i = -flag_before; i <= flag_after; i++)
                    [c addMonthBlockWithMonthInterval:i andMonth:flag_month andYear:flag_year];
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:1 andMonth:flag_month andYear:flag_year];
            }
        } else
        {
            if (flag_month == 0) {
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:-1 andMonth:(int)[now month] andYear:(int)[now year]];
                for (int i = -flag_before; i <= flag_after; i++)
                    [c addMonthBlockWithMonthInterval:i andMonth:(int)[now month] andYear:(int)[now year]];
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:1 andMonth:(int)[now month] andYear:(int)[now year]];
            } else {
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:-1 andMonth:flag_month andYear:(int)[now year]];
                for (int i = -flag_before; i <= flag_after; i++)
                    [c addMonthBlockWithMonthInterval:i andMonth:flag_month andYear:(int)[now year]];
                if (flag_3)
                    [c addMonthBlockWithMonthInterval:1 andMonth:flag_month andYear:(int)[now year]];
            }
        }
        [c printWithCol: flag_col];
    }
    return 0;
}
