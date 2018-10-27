//
//  PrintData.m
//  CalendarSMC
//
//  Created by 史梦辰 on 2018/10/25.
//  Copyright © 2018年 史梦辰. All rights reserved.
//

#import "PrintData.h"

@implementation PrintData

int days_of_month[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
//判断闰年
+(BOOL)isLeapYear:(int)year{
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return true;
    }
    else{
        return false;
    }
}

//计算总天数
+(int)daysCount:(int)year{
    BOOL n;
    int day=0;
    for (int i=1;i<year; i++) {
        n=[PrintData isLeapYear:year];
        if(n){
            day=day+366;
        }
        else{
            day=day+355;
        }
    }
    return day;
}
//判断是否是数字
- (BOOL) isNumber:(NSString*)str{
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (isMatch) {
        return true;
    } else {
        return false;
    }
}

+(int)daysCountByMonth:(int)year month:(int)month{
    NSMutableArray *monthDay=[[NSMutableArray alloc] init];
    NSArray *a=[[NSArray alloc]init];
    a=[PrintData getMonthArr:year];
    [monthDay addObjectsFromArray:a];
    int day=[PrintData daysCount:year];
    for (int i=1; i<month; i++) {
        day=day+[[monthDay objectAtIndex:i] intValue];
    }
    return day;
}
+(NSArray *)getMonthArr:(int)year{
    
    NSNumber *none = [[NSNumber alloc] initWithInt:0];
    NSNumber *jan = [[NSNumber alloc] initWithInt:31];
    NSNumber *febLeap = [[NSNumber alloc] initWithInt:29];
    NSNumber *febNotLeap = [[NSNumber alloc] initWithInt:28];
    NSNumber *mar = [[NSNumber alloc] initWithInt:31];
    NSNumber *apr = [[NSNumber alloc] initWithInt:30];
    NSNumber *may = [[NSNumber alloc] initWithInt:31];
    NSNumber *jun = [[NSNumber alloc] initWithInt:30];
    NSNumber *jul = [[NSNumber alloc] initWithInt:31];
    NSNumber *aug = [[NSNumber alloc] initWithInt:31];
    NSNumber *sep = [[NSNumber alloc] initWithInt:30];
    NSNumber *oco = [[NSNumber alloc] initWithInt:31];
    NSNumber *nov = [[NSNumber alloc] initWithInt:30];
    NSNumber *dec = [[NSNumber alloc] initWithInt:31];
    NSArray *a=[[NSArray alloc] init];
    BOOL n=[PrintData isLeapYear:year];
    if (n) {
        a= [[NSArray alloc] initWithObjects:none,jan,febLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
        
    }
    else{
        a= [[NSArray alloc] initWithObjects:none,jan,febNotLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
        
    }
    return a;
}

+ (NSMutableString *) transToEn:(int)month{
    switch (month) {
        case  1:
            return [[NSMutableString alloc] initWithFormat:@"January"];
            break;
        case  2:
            return [[NSMutableString alloc] initWithFormat:@"February"];
            break;
        case  3:
            return [[NSMutableString alloc] initWithFormat:@"March"];
            break;
        case  4:
            return [[NSMutableString alloc] initWithFormat:@"April"];
            break;
        case  5:
            return [[NSMutableString alloc] initWithFormat:@"May"];
            break;
        case  6:
            return [[NSMutableString alloc] initWithFormat:@"June"];
            break;
        case  7:
            return [[NSMutableString alloc] initWithFormat:@"July"];
            break;
        case  8:
            return [[NSMutableString alloc] initWithFormat:@"August"];
            break;
        case  9:
            return [[NSMutableString alloc] initWithFormat:@"September"];
            break;
        case  10:
            return [[NSMutableString alloc] initWithFormat:@"October"];
            break;
        case  11:
            return [[NSMutableString alloc] initWithFormat:@"November"];
            break;
        case  12:
            return [[NSMutableString alloc] initWithFormat:@"December"];
            break;
        default:
            break;
    }
    return [[NSMutableString alloc] initWithFormat:@""];;
}

//输出一个月的日历
-(void)printMonth:(int)year month:(int)month{
    
    NSMutableArray *monthDay=[[NSMutableArray alloc] init];
    NSArray *a=[[NSArray alloc]init];
    a=[PrintData getMonthArr:year];
    [monthDay addObjectsFromArray:a];
    NSString *str=[[NSString alloc] initWithFormat:@"%@",@" Su Mo Tu We Th Fr Sa"];
    NSMutableString *yearStr=[[NSMutableString alloc]initWithFormat:@"%d",year];
    NSMutableString *monthStr=[PrintData transToEn:month];
    [monthStr appendString:@" "];
    [monthStr appendString:yearStr];
    int titlel=(int)yearStr.length;
    int call=(int)str.length;
    int bl=(call-titlel)/2;
    for (int i=0; i<bl-2; i++) {
        printf(" ");
    }
    printf("%s\n Su Mo Tu We Th Fr Sa\n",[monthStr UTF8String]);
    int day=[PrintData daysCountByMonth:year month:month];
    int position = (day + 5) % 7 + 1;
    if (position == 7) {
    }else{
        for (int i = 0; i < position; i++) {
            printf("   ");
        }
    }
    int i;
    for (i = 0; i < (6 - position) + 1;) {
        printf(" %2d",++i);
    }
    if (position == 7) {
    } else {
        printf("\n");
    }
    
    int count = 0;
    for (; i < [[monthDay objectAtIndex:month] intValue]; ) {
        
        printf(" %2d",++i);
        count++;
        if (count == 7) {
            printf("\n");
            count = 0;
        }
    }
    printf("\n");
}

+ (int) getDay0fWeek:(int)year :(int)month :(int)day {
    int days = 0;
    for (int i = 1; i < year; i++) {
        days += 365;
        days += [PrintData isLeapYear:i];
    }
    if ([PrintData isLeapYear:year]) {
        days_of_month[2] = 29;
    }
    else {
        days_of_month[2] = 28;
    }
    for (int i = 1; i < month; i++) {
        days += days_of_month[i];
    }
    days += day;
    return days % 7;
    
}

-(void)printYear:(int)year{
    for (int i = 0; i < 31; i++) {
        printf(" ");
    }
    printf("%4d\n\n", year);
    for (int i = 1; i <= 12; i += 3) {
        [PrintData parallelPrint:year :i :i+2];
    }
}



+ (void) parallelPrint:(int)year :(int)start :(int)end {
   
    char *months[13] = {"", "  January ", " Fabruary ", "   March  ", "   April  ", "    May   ", "   June   ", "   July   ", "  August  ", " September", "  October ", " November ", " December "};
    char *weeks[8] = {"", "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};
    bool need_new_line = true;
    if ([PrintData isLeapYear:year]) {
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
                temp_index[i] = [PrintData getDay0fWeek:year :i :temp_day[i]] + 1;
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

@end

