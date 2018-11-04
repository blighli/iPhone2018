//
//  myCalendar.m
//  myCalendar
//
//  Created by 熊伟刚 on 2018/10/23.
//  Copyright © 2018 熊伟刚. All rights reserved.
//

#import "myCalendar.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]) //替换日志信息

@implementation myCalendar

{
    //保存月份数组
    NSArray *monthArray;
    //日历
    NSCalendar *calendar;
}

//初始化Calendar成员变量
-(id)init {
    self = [super init];
    if (self)
    {
        monthArray = @[@"January",@"February",@"Wednesday",@"April",@"May",@"June",@" July",@"August",@"Septmber",@"October",@"November",@"December"];
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]; //格里高利历
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];//自定义时区
        //设置周日为第一天
        [calendar setFirstWeekday:1];
    }
    return self;
}

//打印当前年当前月日历
-(void)showCurrentMonth
{
    NSDateComponents *comp = [self getCurrentComponents];  //获取components
    for (NSString *str in [self setDateWithMonth:comp.month Year:comp.year]) {
        NSLog(@"%@",str);
    }
}

//打印当前年指定月日历
-(void)showCurrentYearWithMonth:(NSInteger)month
{ //获取components
    NSDateComponents *comp = [self getCurrentComponents];
    for (NSString *str in [self setDateWithMonth:month Year:comp.year])
    {
        NSLog(@"%@",str);
    }
}

//显示指定年所有月日历
-(void)showAllTheYear:(NSInteger)year
{
    NSLog(@"                                %@",[NSString stringWithFormat:@"%ld",year]); //打印年份
    NSLog(@"");
    NSMutableArray *strArray = [[NSMutableArray alloc] init]; //创建一个可变的字符串数组用于存储
    //一个月的需要8行
    for (int i = 0; i < 8; i++)
    {
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
    }
    //每个月的拼起来
    for (int i = 1; i <= 12; i ++)  //每个月
    {
        NSArray *tempArray = [self setDateWithMonth:i Year:year];  //获取当年当月的日历数组
        for (int j = 0; j < 8; j++) //每一行
        {
            NSMutableString *tempStr = [tempArray[j] mutableCopy];  //获取一个当月数组的副本
            if (j > 1)
            {
                //开始打印天数
                while ([tempStr length] <= 20)  //天数不是从周日开始，前面补空格
                {
                    [tempStr appendString:@" "];
                };
            }
            [strArray[j] appendString:tempStr];
            [strArray[j] appendString:@"  "]; //每两个月第一周中间用空格隔开
        }
        if (i % 3 == 0) //打完了上面三个月，开始新的三个月
        {
            for (NSString *str in strArray)
            {
                NSLog(@"%@",str);  //打印出此行
            }
            //创建一个新的数组，用于存储下三个月的数据
            strArray = [[NSMutableArray alloc] init];
            //添加8行，用于下三个月
            for (int i = 0; i < 8; i++)
            {
                [strArray addObject:[NSMutableString stringWithCapacity:0]];
            }
        }
    }
}

-(void)showMonth:(NSInteger)month andYear:(NSInteger)year
{
    for (NSString *str in [self setDateWithMonth:month Year:year]) {
        NSLog(@"%@",str);
    }
}

// 获取当月的component

-(NSDateComponents *)getCurrentComponents
{
    //当前日期
    NSDate *date = [NSDate date];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    return comp;
}
/*
 传入月份，年份 返回月历数组
 */
-(NSArray *)setDateWithMonth:(NSInteger)month Year:(NSInteger)year{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.year = year;       //构建comp对象
    comp.month = month;
    comp.day = 1;
    NSDate *date = [calendar dateFromComponents:comp];
    NSInteger dayOfWeek = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit
                                              inUnit:NSWeekCalendarUnit forDate:date];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger dayOfMonth = range.length;
    return [self calendarWithDayOfWeek:dayOfWeek withTotalDay:dayOfMonth Month:month Year:year];
}

/*
 根据每个月的第一天是星期几，一共几天 ，月，年 返回这个月的月历数组
 
 */
-(NSArray *)calendarWithDayOfWeek:(NSInteger)dayOfWeek withTotalDay:(NSInteger)totalDay Month:(NSInteger)month Year:(NSInteger)year
{
    NSMutableArray *strArray = [[NSMutableArray alloc] init];  //创建一个可变字符，串数组，存年份，月份，星期
    NSMutableString *line = [[NSMutableString alloc] init];  //可变字符串，存具体天数
    [strArray addObject:[NSString stringWithFormat:@"     %@ %ld      ",monthArray[month-1] ,(long)year]];       //存入带有月份，年份的字符串
    [strArray addObject:@"Su Mo Tu We Th Fr Sa "];  //存入星期
    
    NSInteger count = dayOfWeek;   //计数器记录每月第一天是星期几
    for (int i = 1 ; i < dayOfWeek; i++)
    {  //前面补空格，第一天还未开始
        [line appendString:@"   "];
    }
    //存入具体天数，从1开始
    for (int i = 1 ; i <= totalDay; i++)
    {
        [line appendFormat:@"%2d ",i];
        if (count % 7 == 0)
        {
            //第七天之后不留空格
            [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
            [strArray addObject:line];
            line = [[NSMutableString alloc] init];
        }
        count ++;
    }
    //去掉最后一天的空格
    if (![line isEqualToString:@""])
    {
        [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
        [strArray addObject:line];
    }
    while ([strArray count] < 8)
    {
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
    }
    
    return strArray;
}


@end
