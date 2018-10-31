//
//  CalPrinter.m
//  Cal
//
//  Created by dawn on 2018/10/19.
//  Copyright © 2018 dawn. All rights reserved.
//
#define UNDEFINE -1
#define MAX_MONTH_NUMBER 6 * 7
#import "CalPrinter.h"
#import "DateHelper.h"

@implementation CalPrinter



-(void)prin:(int)year and:(int)month and:(int)day {
    if (![self paramLegal:year and:month and:day]) {
        printf("%s", "Parameter Error");
    }
    if (month == UNDEFINE) {
        // all year
        [self printYear:year];
    } else {
        // only month
        [self printMonth:year and:month];
    }
}
// 单独打印月份
-(void) printMonth:(int) year and:(int)month {
    NSMutableString *formatMonth = [self formatMonth:month];
    DateHelper *dateHlper = [[DateHelper alloc] init];
    int arr[MAX_MONTH_NUMBER];
    [self getDateArray:year and:month and:arr];
    printf("      %s  %d\n", [formatMonth UTF8String], year);
    printf("%s\n", [[self formatWeek] UTF8String]);
    for (int i = 0; i < MAX_MONTH_NUMBER; i++) {
        if (![dateHlper isLegal:year and:month and:arr[i]]) {
            printf("    ");
        } else {
            printf("%3d ", arr[i]);
        }
        if ((i + 1) % 7 == 0) {
            printf("\n");
        }
    }
}

// 打印整年
-(void) printYear:(int) year{
    printf("                                          %d\n", year);
    NSString *months[] = {
        @"         Jan                            Feb                             Mar",
        @"         Apr                            May                             Jun",
        @"         Jul                            Aug                             Sep",
        @"         Oct                            Nov                             Dec"};
    int arr[12][MAX_MONTH_NUMBER];
    for (int i = 0; i < 12; i++) {
        [self getDateArray:year and:i + 1 and:arr[i]];
    }
    for (int i = 0; i < MAX_MONTH_NUMBER * 12; i++) {
        if (i % (MAX_MONTH_NUMBER * 3) == 0) {
            printf("%s\n", [months[i / (MAX_MONTH_NUMBER * 3)] UTF8String]);
            printf("%s\n", [[self formatFourWeek] UTF8String]);
        }
        DateHelper *dateHlper = [[DateHelper alloc] init];
        int top = i / 21;
        int left = i % 21;
        int month = 3 * (top / 6) + left / 7;
        left = left % 7;
        int day = (top * 7 + left) % (MAX_MONTH_NUMBER);
        int number = arr[month][day];
        if (![dateHlper isLegal:year and:month and:number]) {
            printf("    ");
        } else {
            printf("%3d ", number);
        }
        if ((i + 1) % 21 == 0) {
            printf("\n");
        }
    }
}

- (NSString*) formatWeek {
    return @"Sun Mon Tue Wed Thu Fri Sat";
}

- (NSString*) formatFourWeek {
    return @"Sun Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat";
}

// 根据年月获取具体日期信息
- (void) getDateArray: (int)year and:(int)month and:(int[])arr {
    DateHelper *dateHlper = [[DateHelper alloc] init];
    int startWeek = [dateHlper getElapsedWeek:year and:month and:1];
    int startIndex = 0;
    if (startWeek != 7) {
        for (; startIndex < startWeek; startIndex++) {
            arr[startIndex] = 0;
        }
    }
    int num = 1;
    for (; startIndex < MAX_MONTH_NUMBER; startIndex++) {
        arr[startIndex] = num++;
    }
}

// 格式化月份
- (NSMutableString *) formatMonth:(int)month{
    switch (month) {
        case  1:
            return [[NSMutableString alloc]initWithFormat:@"Jan"];
            break;
        case  2:
            return [[NSMutableString alloc]initWithFormat:@"Feb"];
            break;
        case  3:
            return [[NSMutableString alloc]initWithFormat:@"Mar"];
            break;
        case  4:
            return [[NSMutableString alloc]initWithFormat:@"Apr"];
            break;
        case  5:
            return [[NSMutableString alloc]initWithFormat:@"May"];
            break;
        case  6:
            return [[NSMutableString alloc]initWithFormat:@"Jun"];
            break;
        case  7:
            return [[NSMutableString alloc] initWithFormat:@"Jul"];
            break;
        case  8:
            return [[NSMutableString alloc]initWithFormat:@"Aug"];
            break;
        case  9:
            return [[NSMutableString alloc]initWithFormat:@"Sep"];
            break;
        case  10:
            return [[NSMutableString alloc]initWithFormat:@"Oct"];
            break;
        case  11:
            return [[NSMutableString alloc]initWithFormat:@"Nov"];
            break;
        case  12:
            return [[NSMutableString alloc]initWithFormat:@"Dec"];
            break;
    }
    return [[NSMutableString alloc] initWithFormat:@""];;
}

-(BOOL)paramLegal:(int)year  and:(int)month and:(int)day {
    if (year < -1) {
        return false;
    }
    if (month == 0 || month < -1 || month > 12) {
        return false;
    }
    if (day == 0 || day < -1 || day > 31) {
        return false;
    }
    return true;
}

@end
