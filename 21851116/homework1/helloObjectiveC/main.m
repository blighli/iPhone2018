//
//  main.m
//  helloObjectiveC
//
//  Created by 张若静 on 2018/10/21.
//  Copyright © 2018年 zhangruojing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"


@implementation MyCalendar

//初始化月份数组和当前日期
- (void)initMonthArrayAndData {
    monthArray = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
    //获取当前系统日期
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *arr = [dateString componentsSeparatedByString:@"-"];
    
    currentYear = [[arr objectAtIndex:0] intValue];
    currentMonth = [[arr objectAtIndex:1] intValue];
    
}

//打印日历的头信息
- (void) printWeekday{
    printf("日 一 二 三 四 五 六  ");
}

//打印空行
- (void) printNextline{
    printf("\n");
}

//
-(bool)isLeapYear:(int)year{
    bool ans=false;
    if((year%4==0&&year%100!=0)||year%400==0){
        ans=true;
    }
    return ans;
}

//计算某年某月月初对应的星期
- (int) calWeekday: (int)year andMonth:(int) month{
    
    int leapYear[13] = { 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    int normalYear[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    
    int m,day,weekday;
    
    weekday = (int)(floor(year-1+(year-1)/4.0-(year-1)/100.0+(year-1)/400.0+1))%7;
    
    for(m = 1; m < month; m++)
    {
        if([self isLeapYear:year]){
            day=leapYear[m];
        }
        else{
            day=normalYear[m];
        }
        weekday = (weekday+day)%7;
    }
    return weekday;
}

//
- (int) calDay:(int) month andYear:(int) year{
    int leapYear[13] = { 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    int normalYear[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    int day;

    if([self isLeapYear:year]){
            day=leapYear[month];
        }
        else{
            day=normalYear[month];
        }
    return day;
}

//打印日历
- (void) printCarlendar:(int) year andMonth:(int) month{
    int i,j,month1,day,m,month2,l,weekdayMonth;
    int weekday[13];
    int days[13];
    int currentday[13];
    for(i = 0;i<13;i++)
        currentday[i] = 1;
    i = 0;
    //打印某一年
    if(month == 0)
    {
        //打印年份
        printf("         %d\n\n", year);
        for(month1 = 1;month1 <= 12;month1 = month1 + 3)
        {
            NSString *monthStr1 = [monthArray objectAtIndex:(month1 - 1)];
            NSString *monthStr2 = [monthArray objectAtIndex:(month1 - 1 + 1)];
            NSString *monthStr3 = [monthArray objectAtIndex:(month1 - 1 + 2)];
            //打印月份标题
            printf("         %s                 %s                  %s\n",[[monthStr1 description] UTF8String],[[monthStr2 description] UTF8String],[[monthStr3 description] UTF8String]);
            [self printWeekday];
            [self printWeekday];
            [self printWeekday];
            [self printNextline];
            //一个月最多占五行
            for(m = 0;m<6;m++)
            {
                //每一排显示三个月
                for(i = 0;i<3;i++)
                {
                    month2 = month1 + i;
                    if(m == 0)
                    {
                        weekday[month2] = [self calWeekday:year andMonth:month2];
                        //weekday[month2] = calWeekday(year,month2);
                        days[month2] = [self calDay:month2 andYear:year];
                        //days[month2] = calDay(month2,year);
                        for(j = 0;j<weekday[month2];j++)
                        {
                            printf("   ");
                        }
                    }
                    //当遇到最后一行的时候判断留空距离
                    if(currentday[month2] > days[month2])
                    {
                        printf(" ");
                        for(l = 0;l<7;l++)
                        {
                            printf("   ");
                        }
                    }
                    for(j = currentday[month2];j<=days[month2];j++)
                    {
                        printf("%2d ",j);
                        weekday[month2] = (weekday[month2] + 1)%7;
                        if(weekday[month2] == 0 && j != days[month2])
                        {
                            printf(" ");
                            currentday[month2] = j + 1;
                            break;
                        }
                        if(j >= days[month2])
                        {
                            printf(" ");
                            currentday[month2] = j + 1;
                            if(weekday[month2] != 0)
                            {
                                for(l = 0;l<7-weekday[month2];l++)
                                {
                                    printf("   ");
                                }
                            }
                        }
                    }
                }
                [self printNextline];
            }
        }
    }else
        //打印某年某月
    {
        weekdayMonth=[self calWeekday:year andMonth:month];
        NSString *monthStr = [monthArray objectAtIndex:(month - 1)];
        printf("     %s %d\n", [[monthStr description] UTF8String], year);
        [self printWeekday];
        [self printNextline];
        day = [self calDay:month andYear:year];
        for(j=0;j<weekdayMonth;j++)
        {
            printf("   ");
        }
        for(i=1;i<=day;i++)
        {
            printf("%2d ",i);
            weekdayMonth = (weekdayMonth + 1) % 7;
            if(weekdayMonth == 0)
            {
                [self printNextline];
            }
        }
        [self printNextline];
    }
}


- (int) currentYear{
    return currentYear;
}
- (int) currentMonth{
    return currentMonth;
}
@end



int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        NSString *inputStr1 = @"";
        NSString *inputStr2 = @"";
        NSString *inputStr3 = @"";
        int found = 0;
        
        switch(argc){
            case 2:
                found = 1;
                inputStr1 = [NSString stringWithFormat:@"%s",argv[1]];
                break;
            case 3:
                found = 2;
                inputStr1 = [NSString stringWithFormat:@"%s",argv[1]];
                inputStr2 = [NSString stringWithFormat:@"%s",argv[2]];
                break;
            case 4:
                found = 3;
                inputStr1 = [NSString stringWithFormat:@"%s",argv[1]];
                inputStr2 = [NSString stringWithFormat:@"%s",argv[2]];
                inputStr3 = [NSString stringWithFormat:@"%s",argv[3]];
                break;
            default:
                found=0;
        }
        
        // insert code here...
//        NSLog(@"Hello, World!");
        

        
        MyCalendar *calendar = [[MyCalendar alloc]init];
        //初始化日期字符串数组
        [calendar initMonthArrayAndData];
        
//        int found = [calendar spliteString:inputStr];
        
         
        int year,month;
//        NSLog(@"%d", found);
        
        switch(found){
            case 1:
                year = [calendar currentYear];
                month = [calendar currentMonth];
                [calendar printCarlendar:year andMonth:month];
                break;
            case 2:
                year = [inputStr2 intValue];
                if (year<0 || year>9999) {
                    printf("参数错误");
                    break;
                }
                [calendar printCarlendar:year andMonth:0];
                break;
            case 3:
                if([inputStr2  isEqual: @"-m"]){
                    month = [inputStr3 intValue];
                    if(month<1||month>12){
                        printf("参数错误");
                        break;
                    }
                    [calendar printCarlendar: [calendar currentYear] andMonth:month];
                }else{
                    month=[inputStr2 intValue];
                    year=[inputStr3 intValue];
                    if(month<1||month>12||year<0||year>9999){
                        printf("参数错误");
                        break;
                    }
                     [calendar printCarlendar: year andMonth:month];
                }
                
                break;
               
            default:
                printf("输入参数有误\n");
                break;
        }
        
    }
    
    return 0;
}

