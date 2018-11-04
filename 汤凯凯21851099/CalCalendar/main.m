//
//  main.m
//  CalCalendar
//
//  Created by 汤凯凯 on 2018/10/12.
//  Copyright © 2018 汤凯凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCalendar+CalendarUtils.h"

bool isNumber(const char *str) {
    size_t size = strlen(str);
    for (int i = 0; i < size; i++) {
        if (str[i] < '0' || str[i] > '9') {
            return false;
        }
    }
    return true;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        switch (argc) {
            case 1:
                // ./cal: print the calendar of the current month of the current year
                [NSCalendar printCalendarOfMonth:[NSCalendar getCalendarOfMonthByYear:[NSCalendar currentYear] andMonth:[NSCalendar currentMonth]]];
                return 0;
            case 2:
                // ./cal <year>: print the calendar of the specified year
                if (isNumber(argv[1])) {
                    for (int i = 1; i <= 12; ++i) {
                        [NSCalendar printCalendarOfMonth:[NSCalendar getCalendarOfMonthByYear:atoi(argv[1]) andMonth:i]];
                        printf("\n\n");
                    }
                    return 0;
                }
            case 3:
                // ./cal -m <month>: print the calendar of the specified month of current year
                // ./cal <month> <year>: print the calendar of the specified month of the specified year
                if (strcmp(argv[1], "-m") == 0) {
                    if (isNumber(argv[2])) {
                        int month = atoi(argv[2]);
                        if (month >= 1 && month <= 12) {
                            [NSCalendar printCalendarOfMonth:[NSCalendar getCalendarOfMonthByYear:[NSCalendar currentYear] andMonth:month]];
                            return 0;
                        }
                    }
                } else if (isNumber(argv[1]) && isNumber(argv[2])) {
                    int month = atoi(argv[2]);
                    if (month >= 1 && month <= 12) {
                        [NSCalendar printCalendarOfMonth:[NSCalendar getCalendarOfMonthByYear:atoi(argv[1]) andMonth:month]];
                        return 0;
                    }
                }
            default:
                printf("Sorry, it only supports commands followed for now:\n"
                       "\tcal: print the calendar of the current month\n"
                       "\tcal <year>: print the calendar of the specified year\n"
                       "\tcal -m <month>: print the calendar of the specified month of current year\n"
                       "\tcal <month> <year>: print the calendar of the specified month of the specified year");
                break;

        }
    }
    return 0;

}