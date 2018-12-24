//
//  main.m
//  HOMEWORK1
//
//  Created by Gc on 2018/10/14.
//  Copyright © 2018年 Gc. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *err_msg=@"invalid input!";
NSString *none=@"";

NSString *weekHeadOfMonth=@"日  一 二  三 四 五 六";
NSString *weekHeadOfYear=@"日  一 二  三 四 五  六   日  一 二  三 四 五  六   日  一 二  三 四 五 六";
NSString *monthList[12]={@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"};
NSString *colList[4]={@"         一月                    二月                      三月",@"         四月                    五月                      六月",@"         七月                     八月                      九月",@"         十月                    十一月                      十二月"};
int dayslist[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int dayslistInMY[12]={31,29,31,30,31,30,31,31,30,31,30,31};


int monthHasDays(NSInteger year,NSInteger month){
    int ans=0;
    if((year%400==0))
        ans=dayslistInMY[month-1];
    else if((year%100==0))
        ans=dayslist[month-1];
    else if((year%4==0))
        ans=dayslistInMY[month-1];
    else
        ans=dayslist[month-1];
    return ans;
}

NSInteger firstWeekday(NSInteger year,NSInteger month){
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *settedComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    [settedComps setYear:year];
    [settedComps setMonth:month];
    [settedComps setDay:1];
    [settedComps setHour:0];
    [settedComps setMinute:0];
    [settedComps setSecond:0];
    NSDate *settedDay=[calendar dateFromComponents:settedComps];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:settedDay];
    return [comps weekday];
}


void printByMonth(NSInteger year,NSInteger month){
    if(month>=1&&month<=12&&year>=0){
        NSLog(@"      %@ %d",monthList[month-1],year);
        NSLog(weekHeadOfMonth);
            
        NSInteger firstWeekdayAt=firstWeekday(year,month);
        int today=1;
        while(today<=monthHasDays(year,month)){
            NSString *lineStr=@"";
            //第一行需要额外补空格
            for(int i=1;i<firstWeekdayAt;i++){
                lineStr=[lineStr stringByAppendingString:@"   "];
            }
            for(int i=firstWeekdayAt;i<=7;i++){
                NSString *temp;
                if(today<10)
                    temp=[NSString stringWithFormat:@" %d ",today];
                else
                    temp=[NSString stringWithFormat:@"%d ",today];
                lineStr=[lineStr stringByAppendingString:temp];
                today++;
            }
            NSLog(lineStr);
            
            while(today<=monthHasDays(year,month)){
                lineStr=@"";
                for(int i=1;i<=7;i++){
                    NSString *temp;
                    if(today<10)
                        temp=[NSString stringWithFormat:@" %d ",today];
                    else
                        temp=[NSString stringWithFormat:@"%d ",today];
                    lineStr=[lineStr stringByAppendingString:temp];
                    today++;
                    if(today>monthHasDays(year,month))
                        break;
                }
                NSLog(lineStr);
            }
        }
    }
    else{
        NSLog(err_msg);
    }
}

void printByYear(NSInteger year){
    if(year>=0){
        NSLog(@"                                %d",year);
        
        //draw in group
        for(int col=0;col<4;col++){
            NSLog(colList[col]);
            NSLog(weekHeadOfYear);
            NSInteger firstWeekdayAt1=firstWeekday(year,1+col*3);
            NSInteger firstWeekdayAt2=firstWeekday(year,2+col*3);
            NSInteger firstWeekdayAt3=firstWeekday(year,3+col*3);
            int today1=1;
            int today2=1;
            int today3=1;
            
            NSString *lineStr=@"";
            //第一行需要额外补空格
            for(int i=1;i<firstWeekdayAt1;i++){
                lineStr=[lineStr stringByAppendingString:@"   "];
            }
            for(int i=firstWeekdayAt1;i<=7;i++){
                NSString *temp;
                if(today1<10)
                    temp=[NSString stringWithFormat:@" %d ",today1];
                else
                    temp=[NSString stringWithFormat:@"%d ",today1];
                lineStr=[lineStr stringByAppendingString:temp];
                today1++;
            }
            lineStr=[lineStr stringByAppendingString:@"  "];
            for(int i=1;i<firstWeekdayAt2;i++){
                lineStr=[lineStr stringByAppendingString:@"   "];
            }
            for(int i=firstWeekdayAt2;i<=7;i++){
                NSString *temp;
                if(today2<10)
                    temp=[NSString stringWithFormat:@" %d ",today2];
                else
                    temp=[NSString stringWithFormat:@"%d ",today2];
                lineStr=[lineStr stringByAppendingString:temp];
                today2++;
            }
            lineStr=[lineStr stringByAppendingString:@"  "];
            for(int i=1;i<firstWeekdayAt3;i++){
                lineStr=[lineStr stringByAppendingString:@"   "];
            }
            for(int i=firstWeekdayAt3;i<=7;i++){
                NSString *temp;
                if(today3<10)
                    temp=[NSString stringWithFormat:@" %d ",today3];
                else
                    temp=[NSString stringWithFormat:@"%d ",today3];
                lineStr=[lineStr stringByAppendingString:temp];
                today3++;
            }
            NSLog(lineStr);
            
            
            
            while((today1<=monthHasDays(year,1+col*3))||(today2<=monthHasDays(year,2+col*3))||(today3<=monthHasDays(year,3+col*3))){
                lineStr=@"";
                for(int i=1;i<=7;i++){
                    NSString *temp;
                    if(today1<10){
                        if(today1>monthHasDays(year,1+col*3))
                            temp=[NSString stringWithFormat:@"   ",today1];
                        else
                            temp=[NSString stringWithFormat:@" %d ",today1];
                    }
                    else{
                        if(today1>monthHasDays(year,1+col*3))
                            temp=[NSString stringWithFormat:@"   ",today1];
                        else
                            temp=[NSString stringWithFormat:@"%d ",today1];
                    }
                    lineStr=[lineStr stringByAppendingString:temp];
                    today1++;
                }
                lineStr=[lineStr stringByAppendingString:@"  "];
                for(int i=1;i<=7;i++){
                    NSString *temp;
                    if(today2<10){
                        if(today2>monthHasDays(year,2+col*3))
                            temp=[NSString stringWithFormat:@"   ",today2];
                        else
                            temp=[NSString stringWithFormat:@" %d ",today2];
                    }
                    else{
                        if(today2>monthHasDays(year,2+col*3))
                            temp=[NSString stringWithFormat:@"   ",today2];
                        else
                            temp=[NSString stringWithFormat:@"%d ",today2];
                    }
                    lineStr=[lineStr stringByAppendingString:temp];
                    today2++;
                }
                lineStr=[lineStr stringByAppendingString:@"  "];
                for(int i=1;i<=7;i++){
                    NSString *temp;
                    if(today3<10){
                        if(today3>monthHasDays(year,3+col*3))
                            temp=[NSString stringWithFormat:@"   ",today3];
                        else
                            temp=[NSString stringWithFormat:@" %d ",today3];
                    }
                    else{
                        if(today3>monthHasDays(year,3+col*3))
                            temp=[NSString stringWithFormat:@"   ",today3];
                        else
                            temp=[NSString stringWithFormat:@"%d ",today3];
                    }
                    lineStr=[lineStr stringByAppendingString:temp];
                    today3++;
                }
                NSLog(lineStr);
            }
            NSLog(@"");
            NSLog(@"");
        }
        
        
        
    }
    else{
        NSLog(err_msg);
    }
}
NSInteger getMonthOfNow(){
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    now=[NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:now];
    return [comps month];
}

NSInteger getYearOfNow(){
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    now=[NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:now];
    return [comps year];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        char input[100];
        char seg1[100];
        char seg2[100];
        char seg3[100];
        gets(input);
        sscanf(input,"%s %s %s", seg1,seg2,seg3);
        NSString *str1=[NSString stringWithUTF8String:seg1];
        NSString *str2=[NSString stringWithUTF8String:seg2];
        NSString *str3=[NSString stringWithUTF8String:seg3];
       
        if(![str1 isEqualToString:@"cal"]){
            NSLog(err_msg);
        }
        else{
            if([str2 isEqualToString:@"-m"]){
                printByMonth(getYearOfNow(), [str3 intValue]);
            }
            else if([str2 isEqualToString:none]){
                printByMonth(getYearOfNow(), getMonthOfNow());
            }
            else{
                int value1=[str2 intValue];
                int value2=[str3 intValue];
                if(value1==0)
                    NSLog(err_msg);
                else{
                    if(value2==0){
                        //only year
                        printByYear([str2 intValue]);
                    }
                    else{
                        //both
                        printByMonth([str3 intValue], [str2 intValue]);
                    }
                }
                
                //NSString *ans=[NSString stringWithFormat:@"%d",value];
               
            }
        }
   
    }
    return 0;
}
