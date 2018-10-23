//
//  main.m
//  cal
//
//  Created by M David on 18-10-17.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>
#import "Print.h"
#import "Judge.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        int year=0,month=0,defaultYear=0,defaultMonth=0;
        char* monthCall[13]={""," Jan"," Feb"," Mar"," Apr"," May"," Jun"," Jul"," Aug","Sept"," Oct","Nov","Dec"};
        NSDate *nowtime=[[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSDateComponents *nsdComps=[[NSDateComponents alloc] init];
        NSCalendar *nscal=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        nsdComps=[nscal components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:nowtime];
        NSTimeZone *nstz=[[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
        [nsdComps setTimeZone:nstz];
        defaultYear=[nsdComps year];
        defaultMonth=[nsdComps month];
        year=defaultYear;
        month=defaultMonth;
        if(argc<4&&argc>0){
            if(argc==2){
                //judge the first parameters type is int or not
                if(argv[1][0]>='0'&&argv[1][0]<='9'){
                    year=atoi(argv[1]);
                    if([Judge yearJudge:year]){
                        printf("            %d\n",year);
                        for(int i=1;i<13;i++){
                            printf("            %s\n",monthCall[i]);
                            [Print printMonth:year :i];
                        }
                    }else{
                        printf("year %d not int the range of 1...9999\n",year);
                    }
                }else{
                    printf("usage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n");
                }
                
            }else{
                if(argc==1){
                    printf("        %s    %d\n",monthCall[month],year);
                    [Print printMonth:year :month];
                }else{
                    if(strcmp(argv[1],"-m")==0){
                        //judge the second parameters type is int or not
                        if(argv[2][0]>='0'&&argv[2][0]<='9'){
                            month=atoi(argv[2]);
                            if([Judge monthJudge:month]){
                                printf("        %s    %d\n",monthCall[month],year);
                                [Print printMonth:year:month];
                            }else{
                                printf("%d is neither a month number of (1..12)",month);
                            }
                        }else{
                            printf("usage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n");
                        }
                        
                    }else{
                        //judge the params type is int or not
                        if(argv[1][0]>='0'&&argv[1][0]<='9'&&argv[2][0]>='0'&&argv[2][0]<='9'){
                            year=atoi(argv[2]);
                            month=atoi(argv[1]);
                            if([Judge yearJudge:year]){
                                if([Judge monthJudge:month]){
                                    printf("        %s    %d\n",monthCall[month],year);
                                    [Print printMonth:year :month];
                                }else{
                                    printf("%d is neither a month number of (1..12)",month);
                                }
                            }else{
                                printf("year %d not int the range of 1...9999\n",year);
                            }
                        }else{
                            printf("usage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n");
                        }
                        
                    }
                    
                }
            }
        }else{
            //parms num invalid
            printf("usage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n");
        }
    }
    return 0;
}

