//
//  CalPrinter.m
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#import "CalPrinter.h"

@implementation CalPrinter

-(void)printMonthCal:(Day *)day{
    NSMutableString* monthStr=[day getMonthInEnglish];
    
    printf(" %10s",[monthStr UTF8String]);
    printf("  %4d   \n",day.year);
    printf(" Su Mo Tu We Th Fr Sa\n");
    int num=[day getMonthNum];
    int k=0;
    for (int i=0; i<[day getWeek]; i++) {
        printf("   ");
        k++;
    }
    int i=1;
    while (i<=num) {
        printf(" %2d",i);
        i++;
        k++;
        if(k==7){
            printf("\n");
            k=0;
        }
        
    }
    if(k!=0)
        printf("\n");
    
}

-(void)printYearCal:(Day *)day{
    int year=day.year;
    int count[3][4];
    int empty[3][4];
    Day* days[3][4];
    int month=1;
    for (int j=0; j<4; j++) {
        for (int i=0; i<3; i++) {
            days[i][j]=[[Day alloc] initWithYMD:year :month :1];
            month++;
            count[i][j]=1;
            empty[i][j]=[days[i][j] getWeek]-1;
        }
    }
    
    printf("                             %4d                                 \n",year);
    
    printf("          January               February              March      \n");
    printf(" Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
    int j=0;
    for (int k=0; k<6; k++) {
        for (int zu=0; zu<3; zu++) {
            for (int i=0; i<7; i++) {
                if(empty[zu][j]!=0)
                {
                    printf("   ");
                    empty[zu][j]--;
                }
                else if(count[zu][j]<=[days[zu][j] getMonthNum])
                {
                    printf(" %2d",count[zu][j]++);
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
    printf("          April                 May                   June       \n");
    printf(" Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
    j=1;
    for (int k=0; k<6; k++) {
        for (int zu=0; zu<3; zu++) {
            for (int i=0; i<7; i++) {
                if(empty[zu][j]!=0)
                {
                    printf("   ");
                    empty[zu][j]--;
                }
                else if(count[zu][j]<=[days[zu][j] getMonthNum])
                {
                    printf(" %2d",count[zu][j]++);
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
    printf("          July                  August                September  \n");
    printf(" Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
    j=2;
    for (int k=0; k<6; k++) {
        for (int zu=0; zu<3; zu++) {
            for (int i=0; i<7; i++) {
                if(empty[zu][j]!=0)
                {
                    printf("   ");
                    empty[zu][j]--;
                }
                else if(count[zu][j]<=[days[zu][j] getMonthNum])
                {
                    printf(" %2d",count[zu][j]++);
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
    printf("          October               Novmber               December      \n");
    printf(" Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
    j=3;
    for (int k=0; k<6; k++) {
        for (int zu=0; zu<3; zu++) {
            for (int i=0; i<7; i++) {
                if(empty[zu][j]!=0)
                {
                    printf("   ");
                    empty[zu][j]--;
                }
                else if(count[zu][j]<=[days[zu][j] getMonthNum])
                {
                    printf(" %2d",count[zu][j]++);
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
