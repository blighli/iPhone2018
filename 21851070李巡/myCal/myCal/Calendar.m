//
//  Calendar.m
//  myCal
//
//  Created by 之川 on 2018/10/17.
//  Copyright © 2018 LX. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

int daysOfMonth[2][13] = {{0,31,28,31,30,31,30,31,31,30,31,30,31},
                          {0,31,29,31,30,31,30,31,31,30,31,30,31}};
char* weekName = "Su Mo Tu We Th Fr Sa";
char* monthName[13] = {"","January","February","March","April","May","June","July","August","September","October","November","December"};

//perference
int col = 3;
int horiMargin = 3;
int vertMargin = 1;

//print month
-(void) print:(int)year :(int)month{
    
    //calculate and print board
    int board = (21 - ( (int)log10(year) + 1 + (int)strlen(monthName[month])) )/2-1;
    [self printBlank:board];

    printf("%d %s\n%s\n",year,monthName[month],weekName);
    
    //print blank
    int firstBoard = [self getDayOfWeek:year :month :1] - 1 ;

    //control to print \n
    int chageLine = firstBoard;

    [self printBlank:firstBoard*3];
    
    //print days
    int days = daysOfMonth[ [self isLeap:year] ][ month ];

    for (int i = 1 ; i <= days ; i++ ) {
        if(chageLine++%7==0) printf("\n");
        printf("%2d ",i);
    }
    printf("\n");
}

//print year
-(void) print:(int)year{
    
    int row = ceil(12.0/col);

    int yearBoard = (20*col + horiMargin*(col-1) - (int)log10(year)+1)/2;
    [self printBlank:yearBoard];
    printf("%d\n\n",year);
    
    for(int i = 1 ; i <= row ; i++){
        //0.months wait to be printed
        // calculate board , blank of first day
        // 13 for maxSize (12 x 1)
        int months[13]       = {0};
        int monthsBoard[13]  = {0};
        int monthsFirst[13]  = {0};
        int monthsCount[13]  = {0};
        int j = 0;
        
        int colNum = 0;//change col
        int rowMonth = (i-1)*col+1;
        for(j = 1 ; j <= col ; j++){
            if(rowMonth == 13) break;
            months[j]       = rowMonth;
            monthsBoard[j]  = ((20*col+horiMargin*(col-1))/col - (int)strlen(monthName[rowMonth]) )/2;
            monthsFirst[j]  = [self getDayOfWeek:year :rowMonth :1] - 1;
            monthsCount[j]  = 49;//each month print 49 times
            rowMonth++;
            colNum++;
        }

        
        //1.print monthName
        for(j = 1 ; j <= colNum ; j++){
            //only print beforeboard , monthBoard[0] = 0
            int board = monthsBoard[j-1] + monthsBoard[j];
            [self printBlank:board];
            printf("%s ",monthName[months[j]]);
        }
        printf("\n");
        
        
        //2.print weekName
        for(j = 1 ; j <= colNum ; j++){
            printf("%s",weekName);
            [self printBlank:horiMargin];
        }
        printf("\n");
        
        
        //3.print days
        //7 lines , print a string like"    123456...31   ",print 49 times
        int maxLine = 5 + vertMargin;
        while (maxLine -- ) {
            
            for(j = 1 ; j <= colNum ; j++){
                int startDay = monthsFirst[j];
                int endDay   = startDay + daysOfMonth[[self isLeap:year]][months[j]];
                
                int weeks = 7;
                while (weeks --) {
                    int index = 49 - monthsCount[j];
                    if(index>=startDay && index<endDay){
                        printf("%2d ",index - startDay+1);
                    }else{
                        printf("   ");
                    }
                    monthsCount[j] --;
                }
                [self printBlank:horiMargin-1];
            }
            
            printf("\n");
        }
        //4.print \n
        printf("\n");
    }
}

//todo print different messages
-(void) printHelp{
    printf("Command:\n");
    printf("cal                ---  print this month\n");
    printf("cal [year]         ---  print calendar of [year]\n");
    printf("cal [year] [month] ---  print calendar of [year] [month]\n");
    printf("cal -m [month]     ---  print calendar of [year] [month]\n");
}


//check
-(bool) checkYear:(NSString *)year{
    if([self isNum:year]){
        int yearNum = [year intValue];
        if(yearNum>0){
            return true;
        }else{
            printf("Year must > 0!\n");
            [self printHelp];
            return false;
        }
    }else{
        if(![year isEqual:@"-m"]){
            printf("Param is not an integer!\n");
            [self printHelp];
        }
        return false;
    }
}

-(bool) checkMonth:(NSString *)month{
    if([self isNum:month]){
        int monthNum = [month intValue];
        if (monthNum >0 && monthNum<13){
            return true;
        }else{
            printf("Month must in 1..12!\n");
            [self printHelp];
            return false;
        }
    }else{
        printf("Param is not an integer!\n");
        [self printHelp];
        return false;
    }
}


-(bool) isNum:(NSString *)str{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//tools
//print blanks
-(void) printBlank:(int)margin{
    while (margin--) {
        printf(" ");
    }
}

-(bool) isLeap:(int)year{
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
}

//get the day of the week
//use Zeller's congruence. [reference : https://en.wikipedia.org/wiki/Zeller%27s_congruence]
//h = (q + (13*(m+1)/5 + K + K/4 + J/4 + 5*J) % 7
//q is the day of the month
//m is the month (3 = March, 4 = April, 5 = May, ..., 14 = February)
//K the year of the century ( year mod 100)
//J is the zero-based century (year/100)
-(int) getDayOfWeek:(int)year :(int)month :(int)day{
    
    int q = day;
    int m = (month == 1 || month == 2) ? month+12 : month;
    year  = (month == 1 || month == 2) ? year-1 : year;
    int K = year % 100;
    int J = year/100;
    
    int h = (q + 13*(m+1)/5 + K + K/4 + J/4 + 5*J) % 7;
    
    //convert h to weeknum
    //sun-1 , mon-2 , ... ,sat-7
    h = (h == 0) ? h+7 : h;
    return h;
}

@end
