//
//  Calendar.m
//  Calendar
//
//  Created by 叶晨宇 on 2018/10/21.
//  Copyright © 2018年 叶晨宇. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

-(void)print{
    NSDictionary *monthCh2Int=@{@"一月":@1,@"二月":@2,@"三月":@3,@"四月":@4,@"五月":@5,@"六月":@6,@"七月":@7,@"八月":@8,@"九月":@9,@"十月":@10,@"十一月":@11,@"十二月":@12};
    if (self.assigned==0) {
        //get current year and month
        NSDateFormatter *getYear=[[NSDateFormatter alloc]init];
        NSDateFormatter *getMonth=[[NSDateFormatter alloc]init];
        
        [getYear setDateFormat:@"yyyy"];
        [getMonth setDateFormat:@"MMMM"];
        
        NSDate *now=[[NSDate alloc]init];
        NSString *year=[getYear stringFromDate:now];
        NSString *month=[getMonth stringFromDate:now];
        
        self.year=[year intValue];
        self.month=[monthCh2Int[month]intValue];
    }
    else if(self.assigned==1){
        //get current year
        NSDateFormatter *getYear=[[NSDateFormatter alloc]init];
        [getYear setDateFormat:@"yyyy"];
        
        NSDate *now=[[NSDate alloc]init];
        NSString *year=[getYear stringFromDate:now];
        self.year=[year intValue];  
    }
    else if(self.assigned==2){
        
    }
    //calculate the weekday of the first day in this month
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:self.month];
    [comps setYear:self.year];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [calendar dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents =
    [calendar components:NSCalendarUnitWeekday fromDate:date];
    int dayOfWeek = (int)[weekdayComponents weekday];
    
    //calculate the lenth of this month
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    int numberOfDaysInMonth = (int)range.length;
    
    //start print
    NSLog(@"         %d %d",self.month,self.year);
    NSLog(@"日  一  二  三  四  五  六");
    for (int i=1; i<dayOfWeek; i++) {
        printf("    ");//four
    }
    int nowDay=1;
    for (int i=dayOfWeek; i<=7; i++) {
        printf("%02d  ",nowDay++);//two
    }
    printf("\n");
    while (nowDay<=(int)numberOfDaysInMonth) {
        for (int i=1; i<=7&&nowDay<=(int)numberOfDaysInMonth; i++) {
            printf("%02d  ",nowDay++);
        }
        printf("\n");
    }
}

@end
