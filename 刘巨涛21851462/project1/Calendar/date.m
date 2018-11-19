//
//  date.m
//  Calendar
//
//  Created by Jutao on 2018/10/22.
//  Copyright © 2018 Jutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "date.h"
@implementation Calendar
int days_of_month[12] = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char *months[12] = {"Jan", "Feb ", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"};
char *weeks[7] = {"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};

- (int) countDays:(int)year :(int)month :(int)day{
    int days = 0;
    for (int i = 1; i < year; i++) {
        days += 365;
        days += [self isLeapYear:i];
    }
    if ([self isLeapYear:year]) {
        days_of_month[1] = 29;
    }
    else {
        days_of_month[1] = 28;
    }
    
    for (int i = 0; i < month - 1; i++) {
        days += days_of_month[i];
    }
    days += day;
    return days;
}
// 错误提示
- (void) Print_usage {
    printf("please use:\n");
    printf("           cal\n");
    printf("           cal -m [month]\n");
    printf("           cal [month] [year]\n");
    printf("           cal [year]\n");
    printf("please check:\n");
    printf("             year: positive\n");
    printf("             month: 1-12\n");
}

- (bool) Check_year:(int)year {
    return year > 0;
}

- (bool) Check_month:(int)month {
    return month >= 1 && month <= 12;
}
// 判断是否是闰年
- (bool) isLeapYear:(int)year {
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
}

- (int) getDayOfWeek:(int)year :(int)month :(int)day {
    int days = [self countDays:year :month :day];
    return days % 7;
}
// 打印月
- (void) Print_month:(int)year :(int)month{
    printf("  %s %4d\n", months[month-1], year);
    for (int i = 0; i < 7; i++) {
        printf("%s ", weeks[i]);
    }
    printf("\n");
    if ([self isLeapYear:year]) {
        days_of_month[1] = 29;
    }
    else {
        days_of_month[1] = 28;
    }
    
    int days = days_of_month[month-1];
    int index = [self getDayOfWeek:year :month :1] + 1;
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
// 打印年
- (void) Print_year:(int)year {
    for (int i = 0; i < 31; i++) {
        printf(" ");
    }
    printf("%4d \n\n", year);
    for (int i = 1; i <= 12; i += 3) {
        [self Print_line:year :i :i+2];
    }
}
// 逐行打印
- (void) Print_line:(int)year :(int)start :(int)end {
    
    bool newLineFlag = true;
    
    if ([self isLeapYear:year]) {
        days_of_month[1] = 29;
    }
    else {
        days_of_month[1] = 28;
    }
    
    int temp_day[12], temp_index[12];
    for (int i = start - 1; i <= end - 1; i++) {
        temp_day[i] = 1;
        temp_index[i] = 0;
    }
// 打印月
    for (int i = start - 1; i <= end - 1; i++) {
        if (i != start - 1) {
            printf("          ");
        }
        printf("%s          ", months[i]);
    }
    printf("\n");
    
// 打印周
    for (int i = start - 1; i <= end - 1; i++) {
        if (i != start - 1) {
            for (int j = 0; j < 3; j++) {
                printf(" ");
            }
        }
        for (int j = 0; j < 6; j++) {
            printf("%s ", weeks[j]);
        }
        printf("%s", weeks[6]);
    }
    printf("\n");
    
// 打印日
    while(newLineFlag) {
        for (int i = start - 1; i <= end - 1; i++) {
            if (i != start - 1) {
                for (int j = 0; j < 3; j++) {
                    printf(" ");
                }
            }
            if (temp_index[i] == 0) {
                temp_index[i] = [self getDayOfWeek:year :i :temp_day[i]] + 1;
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
        newLineFlag = false;
        for (int i = start - 1; i <= end - 1; i++) {
            if (temp_day[i] <= days_of_month[i]) {
                newLineFlag = true;
                break;
            }
        }
    }
    printf("\n");
}
@end
