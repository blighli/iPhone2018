//
//  PrintCal.m
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/23.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "PrintCal.h"

@interface PrintCal(){
    NSArray *_numDaysOfMonthArr;
    NSArray *_monthArr;
    int _widthMonth;//一个月份所占宽度
    int _widthYear;//一年所占宽度
    int _year;
}
@end

@implementation PrintCal

//判断是否是闰年；
- (BOOL)isLeapYear:(int)year{
    
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return true;
    }
    else{
        return false;
    }
    
}

- (instancetype)init:(int)year{
    self = [super init];
//    _week = [NSArray arrayWithObjects:@"Mo",@"Tu",@"We",@"Th",@"Fr",@"Sa",@"Su", nil];
    _monthArr = [NSArray arrayWithObjects:@"",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    _widthYear = 64;
    _widthMonth = 20;
    _year = year;
    
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
    
    if ([self isLeapYear:year]) {
        _numDaysOfMonthArr = [[NSArray alloc] initWithObjects:none,jan,febLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
        
    } else {
        _numDaysOfMonthArr = [[NSArray alloc] initWithObjects:none,jan,febNotLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
    }
        
    return self;
}

//得到的星期几的整数
- (int)getDayOfTheWeek:(int)y month:(int)m day:(int)d{
    if((m==1)||(m==2))//如果是一月或二月进行换算
    {
        m+=12;
        y--;
    }
    return (d + 2 * m + 3 * (m + 1) / 5 + y + y / 4 - y / 100 + y / 400 + 1) % 7;
}

- (void)printCalendar:(int)month year:(int)year{
    NSString *month_str = _monthArr[month];
    NSString *year_str = [NSString stringWithFormat:@"%d",year];
    int title_len = month_str.length + year_str.length + 1;
    for (int i = 0; i < (_widthMonth - title_len) / 2; i ++) {
        printf(" ");
    }
    printf("%s %s\n",[month_str UTF8String],[year_str UTF8String]);
    printf("Su Mo Tu We Th Fr Sa \n");
    int start_day = [self getDayOfTheWeek:year month:month day:1];
    for (int i = 0; i < start_day; i ++) {
        printf("   ");
    }
    printf(" 1");
    //第一天单独打印
    if (start_day == 6) {
        printf("\n");
    }
    else{
        printf(" ");
    }
    
    for(int i = 2;i <= [_numDaysOfMonthArr[month] intValue]; i ++){
        //判断数字占几位
        if (i < 10) {
            printf(" %d ",i);
        }
        else{
            printf("%d ",i);
        }
        if ((start_day + i) % 7 == 0) {
            printf("\n");
        }
    }
    printf("\n");
}

- (void)printYear:(NSArray *)monthArr startDay:(NSArray *)startDay{
    int month[3];
    month[0] = [monthArr[0] intValue];
    month[1] = [monthArr[1] intValue];
    month[2] = [monthArr[2] intValue];
    int start[3];
    start[0] = [startDay[0] intValue];
    start[1] = [startDay[1] intValue];
    start[2] = [startDay[2] intValue];
    int maxLine = 0;//最大行数
    //找最大行数
    for (int i = 0; i < 3; i ++) {
        int line = ([_numDaysOfMonthArr[month[i]] intValue] + start[i] + 6) / 7 ;
        if (maxLine < line) {
            maxLine = line;
        }
//        printf("max:%d\n,",maxLine);
    }
    int cnt[3];
    cnt[0] = 1;cnt[1] = 1;cnt[2] = 1;//标记三个月当前的日期
    for (int i = 0; i < maxLine; i ++) {
        //循环打印三个月
        for(int j = 0; j < 3;j ++){
            //输出第一天前面的空格
//            printf("start,j:%d,%d\n",start[j],j);
            for (int k = 0; k < start[j]; k ++) {
                printf("   ");
            }
            for (int k = start[j]; k < 7; k ++) {
                if (cnt[j] < 10) {
                    printf(" %d ",cnt[j]++);
                }
                else if(cnt[j] <= [_numDaysOfMonthArr[month[j]] intValue]){
                    printf("%d ",cnt[j]++);
                }
                else
                    printf("   ");
            }
            printf(" ");
            start[j] = 0;
        }
        printf("\n");
    }
}

- (void)PrintCalendar:(int)year{
    //首先居中打出年份；
    printf("                               %d\n\n",year);
    
    printf("       January               February               March\n");
    printf("Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    NSNumber *month1 = [[NSNumber alloc] initWithInt:1];
    NSNumber *month2 = [[NSNumber alloc] initWithInt:2];
    NSNumber *month3 = [[NSNumber alloc] initWithInt:3];
    NSArray *monthArr = [NSArray arrayWithObjects:month1,month2,month3, nil];
    NSNumber *start1 =[[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:1 day:1]];
    NSNumber *start2 =[[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:2 day:1]];
    NSNumber *start3 =[[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:3 day:1]];
    NSArray *startArr = [NSArray arrayWithObjects:start1,start2,start3, nil];
    [self printYear:monthArr startDay:startArr];
    
    //总共四组，实现第2组；
    printf("        April                  May                   June\n");
    printf("Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    month1 = [[NSNumber alloc] initWithInt:4];
    month2 = [[NSNumber alloc] initWithInt:5];
    month3 = [[NSNumber alloc] initWithInt:6];
    monthArr = [NSArray arrayWithObjects:month1,month2,month3, nil];
    start1 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:4 day:1]];
    start2 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:5 day:1]];
    start3 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:6 day:1]];
    startArr = [NSArray arrayWithObjects:start1,start2,start3, nil];
    [self printYear:monthArr startDay:startArr];
    
    //总共四组，实现第3组；
    printf("         July                 August               September\n");
    printf("Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    month1 = [[NSNumber alloc] initWithInt:7];
    month2 = [[NSNumber alloc] initWithInt:8];
    month3 = [[NSNumber alloc] initWithInt:9];
    monthArr = [NSArray arrayWithObjects:month1,month2,month3, nil];
    start1 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:7 day:1]];
    start2 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:8 day:1]];
    start3 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:9 day:1]];
    startArr = [NSArray arrayWithObjects:start1,start2,start3, nil];
    [self printYear:monthArr startDay:startArr];
    
    //总共四组，实现第4组；
    printf("        October               November             December\n");
    printf("Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    month1 = [[NSNumber alloc] initWithInt:10];
    month2 = [[NSNumber alloc] initWithInt:11];
    month3 = [[NSNumber alloc] initWithInt:12];
    monthArr = [NSArray arrayWithObjects:month1,month2,month3, nil];
    start1 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:10 day:1]];
    start2 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:11 day:1]];
    start3 = [[NSNumber alloc]initWithInt:[self getDayOfTheWeek:_year month:12 day:1]];
    startArr = [NSArray arrayWithObjects:start1,start2,start3, nil];
    [self printYear:monthArr startDay:startArr];
}

@end
