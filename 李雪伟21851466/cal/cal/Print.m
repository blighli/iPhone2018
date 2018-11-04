//
//  Print.m
//  cal
//
//  Created by M David on 18-10-20.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import "Print.h"

@implementation Print
+(void)printMonth:(int)year :(int)month{
    char* dayHead=" Sun Mon Tue Wed Thu Fri Sat\n";
    int monthDays[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    NSCalendar *nscal=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *nsdComps=[[NSDateComponents alloc] init];
    NSTimeZone *nstz=[NSTimeZone timeZoneWithName: @"Asia/Shanghai"];
    [nsdComps setTimeZone:nstz];
    [nsdComps setYear:year];
    [nsdComps setMonth:month];
    [nsdComps setDay:1];
    NSDate *daytime=[nscal dateFromComponents:nsdComps];
    
    int dayNum=monthDays[month];
    int dayOffset=(int)[nscal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:daytime];
    dayOffset=(dayOffset+6)%7;
    printf("%s",dayHead);
    if([Print addOneDay:year]){
        dayNum++;
    }
    for(int i=0;i<dayOffset;i++){
        printf("    ");
    }
    for(int i=1;i<=dayNum;i++){
        [Print printBlank:i];
        printf("%d",i);
        if((i+dayOffset)%7==0){
            printf("\n");
        }
    }
    if((dayNum+dayOffset)%7!=0){
        printf("\n");
    }
    printf("\n");
}

+(bool)addOneDay:(int) year{
    if(year%400==0){
        return true;
    }else{
        if(year%100==0){
            return false;
        }else{
            if(year%4==0){
                return true;
            }else{
                return false;
            }
        }
    }
}

+(void)printBlank:(int) day{
    if(day/10==0){
        printf("   ");
    }else{
        printf("  ");
    }
}

@end
