//
//  Cal.m
//  cal
//
//  Created by dxy on 2018/10/23.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"
#import "Cal.h"

const char* NSStringToChar(NSString *s){
    return [s UTF8String];
}

@implementation Cal
-(id)init{
    self = [super init];
    
    date = [[Date alloc] init];
    MONTH_MAP = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月", @"八月", @"九月",@"十月", @"十一月",@"十二月"];
    return self;
}

-(bool)validateMonth:(const char*)cmonth{
    int month = [[NSString stringWithUTF8String: cmonth] intValue];
    if(month >= 1 && month <= 12){
        return true;
    }else{
        printf("cal: %s is not a month number (1..12)\n", cmonth);
        return false;
    }
}

-(bool)validateYear:(const char*)cyear{
    int year = [[NSString stringWithUTF8String:cyear] intValue];
    if(year >= 1 && year <= 9999){
        return true;
    }else{
        printf("cal: year `%s` not in range 1..9999\n", cyear);
        return false;
    }
}

-(void)printMonthLine:(NSInteger)month andYear:(NSInteger)year andLine:(NSInteger)line{
    if(line == 0){
        printf("日 一 二 三 四 五 六");
        return;
    }
    
    NSInteger firstDayWeekday = [date getMonthFisrtDaysWeekday:month andYear:year];
    NSInteger lastDay = [date getMonthLastDay:month andYear:year];
    NSInteger curDay = [date getCurrentDay];
    NSInteger curMonth = [date getCurrentMonth];
    NSInteger curYear = [date getCurrentYear];
    
    NSInteger day = 7*(line-1) - firstDayWeekday + 2;
    NSInteger stop = day+7;
    
    while(1){
        if(day <= 0 || day>lastDay){
            printf("  ");
        }else{
            if(day == curDay && month == curMonth && year == curYear){
                printf("\033[0m\033[47;30m%2ld\033[0m", day);
            }else{
                printf("%2ld", day);
            }
        }
        day++;
        if(day < stop){
            printf(" ");
        }else{
            break;
        }
    }
}

-(void)printCal:(NSInteger)month andYear:(NSInteger)year{
    printf("      %s %ld\n", NSStringToChar(MONTH_MAP[month-1]), year);
    
    for(int i = 0;i<7;i++){
        [self printMonthLine:month andYear:year andLine:i];
        printf("\n");
    }
}

-(void)printYearCal:(NSInteger)year{
    printf("                            %ld\n",year);
    
    for(int m = 3; m<=12; m+=3){
        for(int line = -1; line < 7; line++){
            for(int month = m-2; month<=m; month++){
                if(line == -1){
                    printf("%17s        ", NSStringToChar(MONTH_MAP[month-1]));
                }else{
                    [self printMonthLine:month andYear:year andLine:line];
                    printf("  ");
                }
            }
            printf("\n");
        }
        if(m!=12){
            printf("\n");
        }
    }
}
@end
