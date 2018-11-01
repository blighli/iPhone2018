/**
 * @author vosamowho
 * @Date   2018/10/17
*/

#import <Foundation/Foundation.h>
#import "calendar.h"

@implementation Calendar


int days_of_month[12] = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

char *weeks[7] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
char *months[12] = {"Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec."};

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

- (void) printUsage {
    printf("Command Line::\n");
    printf("    cal\n");
    printf("    cal -m [month]\n");
    printf("    cal [month] [year]\n");
    printf("    cal [year]\n");
}

- (bool) checkYear:(int)year {
    return year > 0;
}

- (bool) checkMonth:(int)month {
    return month >= 1 && month <= 12;
}

- (bool) isLeapYear:(int)year {
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
}

- (int) getDayOfWeek:(int)year :(int)month :(int)day {
    int days = [self countDays:year :month :day];
    return days % 7;
}

- (void) printMonth:(int)year :(int)month{
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

- (void) printYear:(int)year {
    for (int i = 0; i < 31; i++) {
        printf(" ");
    }
    printf("%4d year by VosAmoWho\n", year);
    for (int i = 1; i <= 12; i += 3) {
        [self printLine:year :i :i+2];
    }
}

- (void) printLine:(int)year :(int)start :(int)end {
    
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
    
    for (int i = start - 1; i <= end - 1; i++) {
        if (i != start - 1) {
            printf("          ");
        }
        printf("     %s     ", months[i]);
    }
    printf("\n");
    
    
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
