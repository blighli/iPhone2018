//
//  main.m
//  CalendarSMC
//
//  Created by 史梦辰 on 2018/10/25.
//  Copyright © 2018年 史梦辰. All rights reserved.
//

#import "YearAndMonthNow.h"
#import "PrintData.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
       
        int month;
        int year;
        PrintData *printM=[[PrintData alloc]init];
        YearAndMonthNow *yearAndMonthNow=[[YearAndMonthNow alloc] init];
        [yearAndMonthNow yearAndMonth];
        year=yearAndMonthNow.yearNow;
        month=yearAndMonthNow.monthNow;
        NSString *argv1=[NSString stringWithUTF8String:argv[1]];
       
        if ([argv1 isEqualToString:@"cal"]) {
            if (argc==2) {
                //执行cal
                [printM printMonth:year month:month];
            }
            else{
                if(argc==3){
                    
                    NSString *argv2=[NSString stringWithUTF8String:argv[2]];
                    BOOL num2=[printM isNumber:argv2];
                     int m=[argv2 intValue];
                   
                    if(m>0&&num2){
                    
                    [printM printYear:m];
                    }else
                    {
                          printf("Year not exist!");
                    }
                 }
                else{
                
                NSString *argv2=[NSString stringWithUTF8String:argv[2]];
                NSString *argv3=[NSString stringWithUTF8String:argv[3]];
                BOOL num2=[printM isNumber:argv2];
                BOOL num3=[printM isNumber:argv3];
             if(argc==4&&num2&&num3)
             {
                //执行cal 10 2018，输出2018年10月的月历
                int m=[argv2 intValue];
                int y=[argv3 intValue];
                if(m>0&&m<13&&y>0){
                [printM printMonth:y month:m];
                }
                else
                {
                    printf("Month or year not exist!");
                }
            }
            else if(argc==4&&num3&&!num2)
            {
                //执行cal -m 10，输出当年10月的月历
                int m=[argv3 intValue];
                if(m>0&&m<13){
                [printM printMonth:year month:m];
                }
                else
                {
                    printf("Month not exist!");
                }
            }
            else
            {
                printf("Year or month is not correct!");
            }
                }
        }//end if argc=2
            
        }
        else{
            printf("Please input correct command!");
        }//end if cal
    
        return 0;
    }
}
