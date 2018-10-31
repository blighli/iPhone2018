//
//  NEWCal.m
//  Calendar
//
//  Created by macos on 2018/10/18.
//  Copyright © 2018 macos. All rights reserved.
//

#import "NEWCal.h"

@implementation NEWCal

-(void) printMonth:(NSUInteger)month ofYear:(NSUInteger)year
{
    //创建NSCalendar对象
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [cal setFirstWeekday:1];
    NSDateComponents *component = [[NSDateComponents alloc] init];
    //设置要访问日历的年月日
    [component setYear:year];
    [component setMonth:month];
    [component setDay:1];
    
    NSDate *date = [cal dateFromComponents:component];
    
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    //获取要询问月份的天数
    NSUInteger daynum = range.length;
    //输出n日历的年份和月份
    printf("    %lu年  %lu月\n", year, month);
    //输出日历的星期
    printf("Su Mo Tu We Th Fr Sa \n");
    //获取1号是星期几
    NSUInteger week = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSUInteger day = 1;
    //输出日历每个月最多6行
    for(int i = 0;i < 6; i++)
    {
        int j = 0;
        //输出第一行
        if(i == 0)
        {
            //输出1号之前的空格
            for(j = 1; j < week; j++)
            {
                printf("   ");
            }
            while(j <= 7)
            {
                printf("%2lu ", day++);
                j++;
            }
            printf("\n");
        }
        else
        {
            for(j = 1;j <= 7;j++)
            {
                //如果日历输出完成，结束循环
                if(day > daynum)
                {
                    printf("\n");
                    break;
                }
                else
                {
                    //判断是否换行
                    if(j == 7)
                    {
                        printf("%2lu\n", day++);
                    }
                    else
                    {
                        printf("%2lu ", day++);
                    }
                }
            }
        }
    }
}

-(void) printYear:(NSUInteger)year
{
    //记录每个月的1号是星期几
    NSUInteger arrFirstofWeek[13];
    //记录每个月有多少天
    NSUInteger arrDaynum[13];
    //记录每个月的日期输出情况
    NSUInteger arrDay[13];
    
    //初始化数组
    memset(arrFirstofWeek, 0, sizeof(arrFirstofWeek));
    memset(arrDaynum, 0, sizeof(arrDaynum));
    memset(arrDay, 0, sizeof(arrDay));
    
    int month = 1;
    
    //按照年份对每个月的天数和1号的星期进行赋值
    for(month = 1; month <= 12; month++)
    {
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [cal setFirstWeekday:1];
        NSDateComponents *component = [[NSDateComponents alloc] init];
        
        [component setYear:year];
        [component setMonth:month];
        [component setDay:1];
        
        NSDate *date = [cal dateFromComponents:component];
        
        NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        
        arrDaynum[month] = range.length;
        
        arrFirstofWeek[month] = [cal ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
        arrDay[month] = 1;
    }
    month = 1;
    //输出年份
    printf("%4lu年\n", year);
    //年日历分成4行，每行三个月
    for(int i = 0; i < 4; i++)
    {
        
        //循环输出每行三个月的月份
        for(int j = 0;j < 3; j++)
        {
            printf("       %2d月           ", month+j+i*3);
            if(j == 2) printf("\n");
        }
        //循环输出每行三个月的星期
        for(int j = 0;j < 3; j++)
        {
            printf("Su Mo Tu We Th Fr Sa  ");
            if(j == 2) printf("\n");
        }
        //输出每个月的月历
        for(int row = 0; row < 6; row++)
        {
            for(int j = 0; j < 3; j++)
            {
                int w = 1;
                if(row == 0)
                {
                    for(w = 1; w < arrFirstofWeek[month+j+i*3]; w++)
                    {
                        printf("   ");
                    }
                    while(w < 7)
                    {
                        printf("%2lu ", arrDay[month+j+i*3]++);
                        w++;
                    }
                    if(w == 7)
                    {
                        //判断是否换行
                        if(j == 2)
                        {
                            printf("%2lu \n", arrDay[month+j+i*3]++);
                        }
                        else
                        {
                            printf("%2lu  ", arrDay[month+j+i*3]++);
                        }
                    }
                }
                else
                {
                    for(w = 1; w <= 7; w++)
                    {
                        if(arrDay[month+j+i*3] <= arrDaynum[month+j+i*3])
                        {
                            
                            printf("%2lu ", arrDay[month+j+i*3]++);
                            if(w == 7)
                            {
                                if(j == 2)
                                {
                                    printf("\n");
                                }
                                else
                                {
                                    printf(" ");
                                }
                            }
                            
                        }
                        else
                        {
                            printf("   ");
                            if(w == 7)
                            {
                                if(j == 2)
                                {
                                    printf("\n");
                                }
                                else
                                {
                                    printf(" ");
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
@end
