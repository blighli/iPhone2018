//
//  cal.m
//  cal
//
//  Created by HuaDream on 2018/10/13.
//  Copyright © 2018年 HuaDream. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cal.h"

@implementation Cal

- (id) init {
    self = [super init];
    if (self) {
        printer = [NSMutableArray array];
        monthName = [NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec", nil];
    }
    return self;
}

- (id) initWithHighlightingDay:(NSDateComponents *) Day {
    highlightingDay = Day;
    return [self init];
}

- (void) addWeekRow {
    //[printer addObject:[NSString stringWithFormat:@"日 一 二 三 四 五 六 "]];
    [printer addObject:[NSString stringWithFormat:@"Su Mo Tu We Th Fr Sa "]];
}

- (void) addTitleRowWithYear:(int)year Month:(int) month {
    [printer addObject:[NSString stringWithFormat:@"     %4s  %4d      ", [monthName[month - 1] UTF8String], year]];
}

- (void) addTitleRowWithMonth:(int) month {
    [printer addObject:[NSString stringWithFormat:@"         %2d          ", month]];
}

- (void) addMonthBlockWithMonth:(int) month andYear: (int) year {
    @autoreleasepool {
        int week;
        if (month < 1 || month > 12)
            return;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        [comps setMonth:month];
        [comps setYear:year];
        NSDate *date = [[NSCalendar autoupdatingCurrentCalendar] dateFromComponents:comps];
        
        NSDateComponents *componets = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
        
        week = (int)[componets weekday] - 1;
        
        NSDate *beginDate = nil;
        double interval = 0;
        
        [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
        
        [self addMonthBlockWithFirstDayInWeek:week andMonth:month andYear:year dayInMonth:(int)interval / 60 / 60 / 24];
    }
}

- (void) addDayRow:(int)startDay startCol:(int)col endDay:(int)endDay highlight:(int) day {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < col * 3; i++)
        [string appendString:@" "];
    for (int i = startDay; i <= endDay; i++) {
        if (i == day)
            [string appendFormat:@"\e[7m%2d\033[0m ", i];
        else
            [string appendFormat:@"%2d ", i];
    }
    for (int i = 0; i < (6 - (col + endDay - startDay)) * 3; i++)
        [string appendString:@" "];
    
    [printer addObject:string];
}

- (void) addBlankRow {
    [printer addObject:@"                     "];
}

- (void) addMonthBlockWithFirstDayInWeek:(int) firstDayInWeek andMonth:(int)month andYear:(int) year dayInMonth:(int)day {
    if (month < 1 || month > 12)
        return;
    [self addTitleRowWithYear:year Month:month];
    [self addWeekRow];
    int hightlight = 0;
    if (highlightingDay != nil && [highlightingDay month] == month && [highlightingDay year] == year) {
        hightlight = (int)[highlightingDay day];
    }
    int col = firstDayInWeek;
    int row = 0;
    
    [self addDayRow:1
           startCol:col
             endDay:7 - firstDayInWeek
          highlight:hightlight];
    for (int i = 7 - firstDayInWeek + 1; i <= day; i += 7) {
        [self addDayRow:i
               startCol:0
                 endDay:i + 6 > day ? day : i + 6
              highlight:hightlight];
        row++;
    }
    for (int i = 5; i > row; i--) {
        [self addBlankRow];
    }
}

- (void) addMonthBlockWithMonthInterval:(int) interval andMonth:(int) month andYear: (int) year  {
    month += interval;
    if (month < 1) {
        year += (month - 12) / 12;
        month = (month) % 12 + 12;
    } else if (month > 12) {
        year += (month - 1) / 12;
        month = (month - 1) % 12 + 1;
    }
    if (year < 1 || year > 9999) {
        return;
    }
    [self addMonthBlockWithMonth:month andYear:year];
}

- (void) print {
    for (NSString *row in printer) {
        printf("%s\r\n", [row UTF8String]);
    }
}

- (void) printWithCol:(int)col {
    for (int i = 0; i < printer.count; i += col * 8) {
        for (int n = 0; n < 8; n++) {
            NSMutableString *rowString = [NSMutableString string];
            for (int j = 0; j < col; j++) {
                int row = i + j * 8 + n;
                if (row < printer.count) {
                    [rowString appendString:printer[row]];
                    [rowString appendString:@"  "];
                }
            }
            printf("%s\r\n", [rowString UTF8String]);
        }
        printf("\r\n");
    }
}
@end
