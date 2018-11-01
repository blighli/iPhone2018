//
//  main.m
//  cal
//
//  Created by Ruyi Chen on 2018/10/23.
//  Copyright © 2018年 Ruyi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <time.h>
int yearnow,monthnow,daynow;
void init_nowdate(void)
{
    time_t current;
    struct tm *local;
  
    time(&current);
    local=localtime(&current);
    
    yearnow=local->tm_year+1900;
    monthnow=local->tm_mon+1;
    daynow=local->tm_mday;
    //weeknow=local->tm_wday;
    
   // printf("%4d年%2d月%02d日星期%d",local->tm_year+1900,local->tm_mon+1,local->tm_mday,local->tm_wday);
}


int Isleap(int year)
{
    if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)))
        return 1;
    else
        return 0;
}

int Max_day(int year, int month)
{
    int Day[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if (Isleap(year) == 1)
        Day[1] = 29;
    return Day[month - 1];
}

int Total_day(int year, int month, int day)
{
    int sum = 0;
    int i = 1;
    for (i = 1; i < month; i++)
        sum = sum + Max_day(year, i);
    sum = sum + day;
    
    return sum;
}

//算出是周几
int Weekday(int year, int month, int day)
{
    int count;
    count = (year - 1) + (year - 1) / 4 - (year - 1) / 100 + (year - 1) / 400 + Total_day(year, month, day);
    count = count % 7;
    return count;
}


void show(int year, int month)
{
    int i = 0, j = 1;
    int week, max;
    week = Weekday(year,month, 1);
    max = Max_day(year,month);
    char wday_name[][13]={"日","一","二","三","四","五","六","七","八","九","十","十一","十二"};
  //  printf("---%d--\n",month);
    printf("\n      %s月 %d年",wday_name[month],year);
    printf("\n 日 一 二 三 四 五 六\n");
    
  //  printf(" ");
    for (i = 0; i < week; i++)
        printf("   ");
    for (j = 1; j <= max; j++)
    {
        printf(" %2d",j);
        if (i % 7 == 6)
            printf("\n");
        i++;
    }
    printf("\n");
}

void PrintErrorYeay(char str[])
{
    printf("year %s not in range 1..9999\n",str);
}

bool checkyear(int year)
{
    if(year>=1||year<=9999)
        return 1;
    else
        return 0;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        init_nowdate();
        int year,month;
        
        
        if (argc == 2)
        {
            //1.执行“cal”命令；
            //执行该命令时argc = 2;argv[1] = cal;argv[2] = null
            //计算当前年月；
            show(yearnow,monthnow);
            printf("\n");
        
        }
        else if(argc == 3)
        {
            //4.执行“cal 2014”命令；
            //这个argv2表示年份；
            sscanf(argv[2],"%d",&year);
            if(!checkyear(year))
                printf("year '%s' not in range 1..9999\n",argv[2]);
            else
            for(int i=1;i<=12;i++)
            {
                show(year,i);
                printf("\n");
            }
            
        }
        else if(argc == 4)
        {
            //2.执行“cal 10 2014”命令；
        
            sscanf(argv[2],"%d",&month);
            sscanf(argv[3],"%d",&year);
            
            
            if(month>=1&&month<=12)
            {
                if(checkyear(year))
                    show(year,month);
                else
                  printf("year '%s' not in range 1..9999\n",argv[3]);
            }
            else if(strcmp(argv[2],"-m")==0)
            {
                //3.执行“cal -m 10”命令；
                //需要输出本年的10月份日历；
                month=year;
                 if(month>=1&&month<=12)
                     show(yearnow,month);
                 else
                    printf("%s is neither a month number (1..12) nor a name\n",argv[3]);
            }
            else
                printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
        }
    
    }
    return 0;
}
