//
//  main.m
//  Calendar
//
//  Created by 叶晨宇 on 2018/10/21.
//  Copyright © 2018年 叶晨宇. All rights reserved.


#import <Foundation/Foundation.h>
#import "Calendar.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc==1||strcmp("cal", argv[1])!=0){
            printf("Invalid Input!\n");
            return 0;
        }
        Calendar *cal=[[Calendar alloc]init];
        if (argc==2) {
            //cal
            cal.assigned=0;
            [cal print];
            return 0;
        }
        else if(argc==3){
            //cal 2018
            int year=atoi(argv[2]);
            if (0<year&&year<9999) {
                for (int month=1; month<=12; month++) {
                    cal.assigned=2;
                    cal.month=month;
                    cal.year=year;
                    [cal print];
                    NSLog(@"\n");
                }
            }
            else printf("Invalid Input!\n");
            return 0;
        }
        else if(argc==4){
            //cal -m 10
            if (!strcmp(argv[2], "-m")) {
                int month=atoi(argv[3]);
                if (1<=month&&month<=12) {
                    cal.assigned=1;
                    cal.month=month;
                    [cal print];
                }
                else printf("Invalid Input!\n");
            }
            else {
                //cal 10 2018
                int year=atoi(argv[3]);
                int month=atoi(argv[2]);
                if (1<=month&&month<=12&&0<year&&year<9999) {
                    cal.assigned=2;
                    cal.month=month;
                    cal.year=year;
                    [cal print];
                }
                else printf("Invalid Input!\n");
            }
            return 0;
        }
        printf("Invalid Input!\n");
    }
    return 0;
}
