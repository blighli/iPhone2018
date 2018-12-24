//
//  logCal.m
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

@implementation LogCal
int daysInMonth[12] = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char *weekDes[7] = {"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};

// 计算给定的某一天是周几
-(NSInteger) weakDayForFirstDayOfMonth:(int)year: (int)month: (int)day {
    NSInteger numOfThisYear = 1;
    Validate *myValidate = [[Validate alloc] init];
    if([myValidate isLeapYear:year]) {
        daysInMonth[1] = 29;
    } else {
        daysInMonth[1] = 28;
    }
    for(int i = 0; i < month-1; i++) {
        numOfThisYear += daysInMonth[i];
    }
    NSInteger W = (year-1)*365 + ((year-1)/4) - ((year-1)/100) + ((year-1)/400) + numOfThisYear;
    NSInteger index = W % 7;
    return index;
}

-(void) logLine:(int)year :(int)startIndex :(int)endIndex {
    Validate *myValidate = [[Validate alloc] init];
    FormatMonth *myFormatMonth = [[FormatMonth alloc] init];
    int startDay[12], startDayIndex[12];
    bool notLogMaxNum = true;
    for (int i = startIndex - 1; i <= endIndex - 1; i++ ) {
        startDay[i] = 1;
        startDayIndex[i] = 0;
    }
    if([myValidate isLeapYear:year]) {
        daysInMonth[1] = 29;
    } else {
        daysInMonth[1] = 28;
    }
    
    for (int i = startIndex; i <= endIndex; i++) {
        printf("     %s     ", [myFormatMonth formatMonth:i]);
        printf("  ");
    }
    printf("\n");
    
    for (int i = startIndex; i <= endIndex; i++) {
        for (int j = 0; j < 7; j++) {
            printf("%s ", weekDes[j]);
        }
        printf("  ");
    }
    printf("\n");
    while(notLogMaxNum) {
        for(int i = startIndex - 1; i < endIndex; i++) {
            if (startDayIndex[i] == 0) {
                startDayIndex[i] = [self weakDayForFirstDayOfMonth:year :i+1 :startDay[i]] + 1;
            }
            for (int j = 1; j < startDayIndex[i]; j++) {
                printf("   ");
            }
            while(startDayIndex[i] < 8) {
                if (startDay[i] <= daysInMonth[i]) {
                    printf("%2d", startDay[i]);
                    startDay[i] += 1;
                }
                else {
                    printf("  ");
                }
                startDayIndex[i] += 1;
                if (startDayIndex[i] != 8) {
                    printf(" ");
                }
            }
            startDayIndex[i] = 1;
            printf("   ");
        }
        
        printf("\n");
        notLogMaxNum = false;
        for (int i = startIndex - 1; i <= endIndex - 1; i++) {
            if (startDay[i] <= daysInMonth[i]) {
                notLogMaxNum = true;
                break;
            }
        }
        
    }
}

-(void) logYear:(int)year {
    printf("                              %4d\n\n", year);
    for (int i = 1; i <= 12; i += 3) {
        [self logLine:year :i :i+2];
        printf("\n\n");
    }
    
}

-(void) logMonth:(NSInteger)year :(NSInteger)month {
    FormatMonth *myFormatMonth = [[FormatMonth alloc] init];
    printf("  %s  %d\n", [myFormatMonth formatMonth:month], year);
    for (int i = 0; i < 7; i++) {
        printf("%s ", weekDes[i]);
    }
    printf("\n");
    NSInteger index = [self weakDayForFirstDayOfMonth:year :month :1];
    NSInteger realIndex = index + 1;
    int days = daysInMonth[month-1];
    for (int i = 1; i < realIndex; i++) {
        printf("   ");
    }
    for (int i = 1; i <= days; i++) {
        if (realIndex == 8) {
            realIndex = 1;
        }
        realIndex += 1;
        printf("%2d", i);
        if (realIndex != 8) {
            printf(" ");
        }
        else if (i != days) {
            printf("\n");
        }
    }
    printf("\n");
    
}
-(void) logUsage {
    printf("cal usage:\n"
           "\tcal\n"
           "\tcal [year]\n"
           "\tcal -m [month]\n"
           "\tcal [month] [year]\n"
           );
}

@end
