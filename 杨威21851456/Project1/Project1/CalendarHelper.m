//
//  CalendarHelper.m
//  Project1
//
//  Created by 杨威 on 2018/10/21.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import "CalendarHelper.h"

@implementation CalendarHelper

static CalendarHelper *_instance;

+(CalendarHelper*)Instance{
    if(_instance == nil){
        _instance =[[CalendarHelper alloc] init];
    }
    return _instance;
}


-(void)printMonth:(int)month withYear:(int)year{
    int _month,_year;
    double interval = 0;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDate *now=[NSDate date];
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSDate *pDate = nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal;
    NSDateComponents *com = [calendar components:calendarUnit fromDate:now];
    
    if(month==0){
        _month =(int)[com month];
    }else{
        _month =month;
    }
    
    if(year==0){
        _year =(int)[com year];
    }else{
        _year =year;
    }
    
    NSString *datestr =[NSString stringWithFormat:@"%04d%02d01",_year,_month];
    
    NSDate *formatterDate=[dateFormatter dateFromString:datestr];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:formatterDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval -1];
    }else {
        return;
    }
    
    int count=interval/24/60/60;
    
    pDate = firstDate;
    printf("    ");
    [self translate:_month];
    printf("月 %d\n",_year);
    printf("日 一 二 三 四 五 六\n");

    com = [calendar components:calendarUnit fromDate:pDate];
    for(int i=1;i<(int)[com weekday];i++){
        printf("   ");
    }
    
    for(int i=0;i<count;i++){
        
        printf("%2d",(int)[com day]);
        int temp1=(int)[com weekday];
        
        if(temp1<7){
            printf(" ");
        }else if(temp1==7){
            printf("\n");
        }
        
        pDate = [pDate dateByAddingTimeInterval:24*60*60];
        com = [calendar components:calendarUnit fromDate:pDate];
    }
    printf("\n");
}

NSMutableArray *Jan,*Feb,*Mat,*Apr,*May,*Jun,*Jul,*Aug,*Sep,*Oct,*Nov,*Dec;

-(void)printYear:(int)year{
    double interval = 0;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDate *now=[NSDate date];
    NSDate *firstDate[12];
    NSDate *lastDate[12];
    NSDate *pDate[12];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal;
    NSDateComponents *com[12];
    
    for(int i=0;i<12;i++){
        com[i] = [calendar components:calendarUnit fromDate:now];
        
        NSString *datestr =[NSString stringWithFormat:@"%04d%02d01",year,i+1];
        
        NSDate *formatterDate=[dateFormatter dateFromString:datestr];
        NSDate *tempDate=nil;
        BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&tempDate interval:&interval forDate:formatterDate];
        firstDate[i]=tempDate;
        if (OK) {
            lastDate[i] = [firstDate[i] dateByAddingTimeInterval:interval -1];
        }else {
            return;
        }
        pDate[i] = firstDate[i];
        com[i] = [calendar components:calendarUnit fromDate:pDate[i]];
        
    }
    
    for(int i=0;i<12;i++){
        [self initMonth:i+1 withFirstDate:firstDate[i] andLastDate:lastDate[i]];
    }
    
    NSArray *month =[[NSArray alloc] initWithObjects:Jan,Feb,Mat,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec, nil];
    

    
    printf("                             %d\n\n",year);
    
    for(int i=0;i<4;i++){
        for(int j=0;j<3;j++){
            [self translate2:3*i+j+1];
        }
        printf("\n");
        for(int i=0;i<2;i++){
            printf("日 一 二 三 四 五 六  ");
        }
        printf("日 一 二 三 四 五 六\n");
        
        for(int j=0;j<6;j++){
            for(int k=0;k<3;k++){
                for(int l=0;l<7;l++){
                    printf("%s ",[[[month objectAtIndex:3*i+k] objectAtIndex :7*j+l] UTF8String]);
                }
                if(k<2){
                    printf(" ");
                }else{
                    printf("\n");
                }
            }
        }
    }
    

}


-(void)translate:(int)num{
    switch (num) {
        case 1:
            printf(" 一");
            break;
        case 2:
            printf(" 二");
            break;
        case 3:
            printf(" 三");
            break;
        case 4:
            printf(" 四");
            break;
        case 5:
            printf(" 五");
            break;
        case 6:
            printf(" 六");
            break;
        case 7:
            printf(" 七");
            break;
        case 8:
            printf(" 八");
            break;
        case 9:
            printf(" 九");
            break;
        case 10:
            printf(" 十");
            break;
        case 11:
            printf("十一");
            break;
        case 12:
            printf("十二");
            break;
        default:
            break;
    }
    
    
    return;
}

-(void)translate2:(int)num{
    switch (num) {
        case 1:
            printf("        一月          ");
            break;
        case 2:
            printf("        二月          ");
            break;
        case 3:
            printf("        三月          ");
            break;
        case 4:
            printf("        四月          ");
            break;
        case 5:
            printf("        五月          ");
            break;
        case 6:
            printf("        六月          ");
            break;
        case 7:
            printf("        七月          ");
            break;
        case 8:
            printf("        八月          ");
            break;
        case 9:
            printf("        九月          ");
            break;
        case 10:
            printf("        十月          ");
            break;
        case 11:
            printf("       十一月          ");
            break;
        case 12:
            printf("      十二月          ");
            break;
        default:
            break;
    }
    
    
    return;
}
-(void)initMonth:(int)num withFirstDate:(NSDate*)fdate andLastDate:(NSDate*)ldate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal;
    NSDateComponents *com;
    
    NSMutableArray *mon=[NSMutableArray arrayWithCapacity:42];
    com = [calendar components:calendarUnit fromDate:fdate];

    int i,j=0;
    for(i=0;i<(int)[com weekday]-1;i++){
        [mon insertObject:@"  " atIndex:i];
        j++;
    }
    com = [calendar components:calendarUnit fromDate:ldate];

    int day=1;
    for(;i<(int)[com day]+j;i++){
        [mon insertObject:[NSString stringWithFormat:@"%2d",day] atIndex:i];
        day++;
    }

    for(;i<42;i++){
        [mon insertObject:@"  " atIndex:i];
    }

    switch (num) {
        case 1:
            Jan=[NSMutableArray arrayWithArray:mon];
            break;
        case 2:
            Feb=[NSMutableArray arrayWithArray:mon];
            break;
        case 3:
            Mat=[NSMutableArray arrayWithArray:mon];
            break;
        case 4:
            Apr=[NSMutableArray arrayWithArray:mon];
            break;
        case 5:
            May=[NSMutableArray arrayWithArray:mon];
            break;
        case 6:
            Jun=[NSMutableArray arrayWithArray:mon];
            break;
        case 7:
            Jul=[NSMutableArray arrayWithArray:mon];
            break;
        case 8:
            Aug=[NSMutableArray arrayWithArray:mon];
            break;
        case 9:
            Sep=[NSMutableArray arrayWithArray:mon];
            break;
        case 10:
            Oct=[NSMutableArray arrayWithArray:mon];
            break;
        case 11:
            Nov=[NSMutableArray arrayWithArray:mon];
            break;
        case 12:
            Dec=[NSMutableArray arrayWithArray:mon];
            break;
        default:
            break;
    }
}

@end
