//
//  PrintCalendar.m
//  ZSCalendarTest
//
//  Created by 赵帅 on 2018/10/16.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PrintCalendar.h"

@implementation PrintCalendar

-(void)printMonth:(YearMonthDay *)monthCal{
    NSMutableString* monthStr=[monthCal transformMonthName];
    printf("      %s",[monthStr UTF8String]);
    printf(" %d\n",monthCal.year);
    printf("日 一 二 三 四 五 六\n");
    int monthDaysNum=[monthCal getMonthDaysNum];
    int dayPoint=0;
    //输出每月第一周第一天前的空格
    for (int i = 0; i < [monthCal getWeekDay]-1; i++) {
        printf("   ");
        dayPoint++;
    }
    int i=1;
    while (i <= monthDaysNum) {
        printf("%2d ",i);
        i++;
        dayPoint++;
        if(dayPoint==7){
            printf("\n");
            dayPoint=0;
        }
    }
    printf("\n");
    printf("\n");
}

-(void)printYear:(YearMonthDay *)yearCal{
    int year=yearCal.year;
    int dayNum[3][4];
    int blank[3][4];
    YearMonthDay* days[3][4];
    int month=1;
    for (int j=0; j<4; j++) {
        for (int i=0; i<3; i++) {
//            days[0][0]，days[1][0]，days[2][0]
//            days[0][1]，days[1][1]，days[2][1]
//            days[0][2]，days[1][2]，days[2][2]
//            days[0][3]，days[1][3]，days[2][3]
            days[i][j]=[[YearMonthDay alloc] getYearMonth:year Month:month];
            month++;
            dayNum[i][j]=1;
            blank[i][j]=(int)[days[i][j] getWeekDay]-1;
        }
    }
    
    printf("                               %d                                 \n",year);
    printf("         一月                  二月                  三月      \n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
    int j=0;
    for (int week=0; week<6; week++) {              //每月日历最多6行
        for (int i=0; i<3; i++) {                   //每行三个周
            for (int day=0; day<7; day++) {         //每个月周7天
                if(blank[i][j]!=0)                  //若起始周第一天不为周日
                {
                    printf("   ");
                    blank[i][j]--;                  //输出空格组直到第一天
                }
                else if(dayNum[i][j]<=[days[i][j] getMonthDaysNum])
                {
                    printf("%2d ",dayNum[i][j]++);  //输出几号
                }
                else
                {
                    printf("   ");
                }
            }
            printf(" ");
        }
        printf("\n");
    }
    printf("\n");
    
    printf("         四月                  五月                  六月      \n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
    j=1;
    for (int week=0; week<6; week++) {              //每月日历最多6行
        for (int i=0; i<3; i++) {                   //每行三个周
            for (int day=0; day<7; day++) {         //每个月周7天
                if(blank[i][j]!=0)                  //若起始周第一天不为周日
                {
                    printf("   ");
                    blank[i][j]--;                  //输出空格组直到第一天
                }
                else if(dayNum[i][j]<=[days[i][j] getMonthDaysNum])
                {
                    printf("%2d ",dayNum[i][j]++);  //输出几号
                }
                else
                {
                    printf("   ");
                }
            }
            printf(" ");
        }
        printf("\n");
    }
    printf("\n");
    
    printf("         七月                  八月                  九月      \n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
    j=2;
    for (int week=0; week<6; week++) {              //每月日历最多6行
        for (int i=0; i<3; i++) {                   //每行三个周
            for (int day=0; day<7; day++) {         //每个月周7天
                if(blank[i][j]!=0)                  //若起始周第一天不为周日
                {
                    printf("   ");
                    blank[i][j]--;                  //输出空格组直到第一天
                }
                else if(dayNum[i][j]<=[days[i][j] getMonthDaysNum])
                {
                    printf("%2d ",dayNum[i][j]++);  //输出几号
                }
                else
                {
                    printf("   ");
                }
            }
            printf(" ");
        }
        printf("\n");
    }
    printf("\n");
    
    printf("         十月                 十一月                十二月      \n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
    j=3;
    for (int week=0; week<6; week++) {              //每月日历最多6行
        for (int i=0; i<3; i++) {                   //每行三个周
            for (int day=0; day<7; day++) {         //每周7天
                if(blank[i][j]!=0)                  //若起始周第一天不为周日
                {
                    printf("   ");
                    blank[i][j]--;                  //输出空格组直到第一天
                }
                else if(dayNum[i][j]<=[days[i][j] getMonthDaysNum])
                {
                    printf("%2d ",dayNum[i][j]++);  //输出几号
                }
                else
                {
                    printf("   ");
                }
            }
            printf(" ");
        }
        printf("\n");
    }
}
@end


