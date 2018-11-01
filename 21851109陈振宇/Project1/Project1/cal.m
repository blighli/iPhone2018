//
//  cal.m
//  Project1
//
//  Created by Zhenyu Chen on 2018/10/11.
//  Copyright © 2018年 Zhenyu Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"

@implementation Cal

// 1.1.1 is monday
int days_of_month[13] = {0, 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char *weeks[8] = {"", "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};
char *months[13] = {"", "  January ", " Fabruary ", "   March  ", "   April  ", "    May   ", "   June   ", "   July   ", "  August  ", " September", "  October ", " November ", " December "};

- (int) count_days:(int)year :(int)month :(int)day{
    /* count the days from 1.1.1 to year.month.day*/
    int days = 0;
    for (int i = 1; i < year; i++) {
        days += 365;
        days += [self is_leap_year:i];
    }
    if ([self is_leap_year:year]) {
        days_of_month[2] = 29;
    }
    else {
        days_of_month[2] = 28;
    }
    for (int i = 1; i < month; i++) {
        days += days_of_month[i];
    }
    days += day;
    return days;
}

// reference: cal command
- (void) print_usage {
    printf("Usage:\n");
    printf("  Command:\n");
    printf("    cal\n");
    printf("    cal -m [month]\n");
    printf("    cal [month] [year]\n");
    printf("    cal [year]\n");
    printf("  Constraint:\n");
    printf("    year: a positive integer\n");
    printf("    month: an integer between 1 and 12\n");
}

- (bool) check_year:(int)year {
    return year > 0;
}

- (bool) check_month:(int)month {
    return month >= 1 && month <= 12;
}

- (bool) is_leap_year:(int)year {
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
}

- (int) get_the_day_of_the_week:(int)year :(int)month :(int)day {
    int days = [self count_days:year :month :day];
    return days % 7;
}

- (void) print_month:(int)year :(int)month{
    printf("  %s %4d\n", months[month], year);
    for (int i = 1; i < 7; i++) {
        printf("%s ", weeks[i]);
    }
    printf("%s\n", weeks[7]);
    if ([self is_leap_year:year]) {
        days_of_month[2] = 29;
    }
    else {
        days_of_month[2] = 28;
    }
    int days = days_of_month[month];
    int index = [self get_the_day_of_the_week:year :month :1] + 1;
    for (int i = 1; i < index; i++) {
        printf("   ");
    }
    for (int i = 1; i <= days; i++) {
        if (index == 8) {
            index = 1;
        }
        index += 1;
        printf("%2d", i);
        if (index != 8) {
            printf(" ");
        }
        else if (i != days) {
            printf("\n");
        }
    }
    printf("\n");
}

- (void) parallel_print:(int)year :(int)start :(int)end {
    bool need_new_line = true;
    if ([self is_leap_year:year]) {
        days_of_month[2] = 29;
    }
    else {
        days_of_month[2] = 28;
    }
    int temp_day[13], temp_index[13];
    for (int i = start; i <= end; i++) {
        temp_day[i] = 1;
        temp_index[i] = 0;
    }
    for (int i = start; i <= end; i++) {
        if (i != start) {
            printf("   ");
        }
        printf("     %s     ", months[i]);
    }
    printf("\n");
    for (int i = start; i <= end; i++) {
        if (i != start) {
            for (int j = 0; j < 3; j++) {
                printf(" ");
            }
        }
        for (int j = 1; j < 7; j++) {
            printf("%s ", weeks[j]);
        }
        printf("%s", weeks[7]);
    }
    printf("\n");
    while(need_new_line) {
        for (int i = start; i <= end; i++) {
            if (i != start) {
                for (int j = 0; j < 3; j++) {
                    printf(" ");
                }
            }
            if (temp_index[i] == 0) {
                temp_index[i] = [self get_the_day_of_the_week:year :i :temp_day[i]] + 1;
            }
            for (int j = 1; j < temp_index[i]; j++) {
                printf("   ");
            }
            while(temp_index[i] < 8) {
                if (temp_day[i] <= days_of_month[i]) {
                    printf("%2d", temp_day[i]);
                    temp_day[i] += 1;
                }
                else {
                    printf("  ");
                }
                temp_index[i] += 1;
                if (temp_index[i] != 8) {
                    printf(" ");
                }
            }
            temp_index[i] = 1;
        }
        printf("\n");
        need_new_line = false;
        for (int i = start; i <= end; i++) {
            if (temp_day[i] <= days_of_month[i]) {
                need_new_line = true;
                break;
            }
        }
    }
    printf("\n");
}

- (void) print_year:(int)year {
    for (int i = 0; i < 31; i++) {
        printf(" ");
    }
    printf("%4d\n\n", year);
    for (int i = 1; i <= 12; i += 3) {
        [self parallel_print:year :i :i+2];
    }
}
@end


