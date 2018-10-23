//
//  Solution.m
//  Cal
//
//  Created by shayue on 2018/10/11.
//  Copyright © 2018 shayue. All rights reserved.
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import "Solution.h"

@implementation Solution

//返回星期几
- (NSUInteger) getWhichDay : (NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setFirstWeekday:1];
	NSUInteger whichday = [cal component:NSCalendarUnitWeekday
								fromDate:date];
	return whichday - 1;
	
}
//返回天
- (NSUInteger) getDay : (NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSUInteger day = [cal component:NSCalendarUnitDay
										  fromDate:date];
	return day;
}
//返回月
- (NSUInteger) getMonth : (NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSUInteger month = [cal component:NSCalendarUnitMonth
										  fromDate:date];
	return month;
}

//返回当前月的天数
- (NSUInteger) getMonthLength : (NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSRange daysInMonth = [cal rangeOfUnit:NSCalendarUnitDay
									inUnit:NSCalendarUnitMonth
								   forDate:date];
	return daysInMonth.length;
}

//返回年
- (NSUInteger) getYear : (NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSUInteger year = [cal component:NSCalendarUnitYear
										  fromDate:date];
	return year;
}

//返回当前月的第一天是星期几? dayInWeek - 当前是星期几; day - 当前是几号
- (NSUInteger) getFirstdayOfMonth : (NSUInteger)dayInWeek : (NSUInteger)day
{
	NSUInteger firstDayOfMonth;
	if(day % 7 == 0)
		firstDayOfMonth = (dayInWeek + 1) % 7;
	else
		firstDayOfMonth = dayInWeek % (day % 7) + 1;
	return firstDayOfMonth;
}

//输出一个月的日历接口
- (void) printOneMonthInterface : (NSDate*) queryTime
{
	NSArray *monthList = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
						   @"九月", @"十月", @"十一月", @"十二月"];
	
	//1. dayInWeek : 查询的这一天是星期几, 范围[0, 6], 0-周日, 1-周一, 2-周二, 3-周三, 4-周四, 5-周五, 6-周六
	NSUInteger dayInWeek = [self getWhichDay:queryTime];
	
	//2. number : 查询的这一天是这个月的几号
	NSUInteger number = [self getDay:queryTime];
	
	//3. month : 查询的这一天是几月份; monthLength : 该月的天数
	NSUInteger month = [self getMonth:queryTime];
	NSUInteger monthLength = [self getMonthLength:queryTime];
	
	//4. year : 查询的这一天处在的年份
	NSUInteger year = [self getYear:queryTime];
	
	//5. firstDayOfCurMonth : 当前月的第一天是星期几
	NSUInteger firstDayOfCurMonth = [self getFirstdayOfMonth:dayInWeek :number];
	
	//6. 格式化输出
	NSLog(@"         %@ %lu         ", monthList[month - 1], year);
	[self printMonth:firstDayOfCurMonth :monthLength];
}

//格式化输出一个月的日历
- (void) printMonth : (NSUInteger)firstDayOfCurMonth
					: (NSUInteger)monthLength
{

	NSLog(@"日\t一\t二\t三\t四\t五\t六");
	for(int i = 0; i < firstDayOfCurMonth; i++)
		printf("    ");
	for(int i = 1; i <= monthLength; i++)
	{
		printf("%2d  ", i);
		if((i + firstDayOfCurMonth) % 7 == 0)
			printf("\n");
	}
	printf("\n");
}

//用设置好的时间返回NSDate
- (NSDate*) getSetDate : (NSUInteger)theYear : (NSUInteger)theMonth
{
	NSDateComponents *com = [[NSDateComponents alloc] init];
	[com setYear:theYear];
	[com setMonth:theMonth+1];
	[com setDay:1];
	[com setHour:12];
	[com setMinute:0];
	[com setSecond:0];	
	NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	return [g dateFromComponents:com];
}

//打印全年的日历
- (void) printAllYear:(NSUInteger)inputYear
{
	int MonthLength[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	
	if(inputYear % 4 == 0)					//如果是闰年,2月总共天数为29
		MonthLength[1] = 29;
	NSLog(@"                                            %lu",  inputYear);
	for(int i = 0; i < 12; i += 3)
	{
		//打印头部
		[self printThreeMonth:i];
		NSUInteger firstDay[3];
		int cnt1, cnt2, cnt3;
		int j1, j2, j3;
		//得到初始值
		NSDate *queryTime;
		queryTime = [self getSetDate:inputYear
									 :i];
		firstDay[0] = [self getWhichDay:queryTime];
		queryTime = [self getSetDate:inputYear
									 :i+1];
		firstDay[1] = [self getWhichDay:queryTime];
		queryTime = [self getSetDate:inputYear
									 :i+2];
		firstDay[2] = [self getWhichDay:queryTime];
		
		//第一次
		for(int j = 0; j < firstDay[0]; j++)
			printf("\t");
		cnt1 = 6 - (int)firstDay[0] + 1;
		for(j1 = 1; cnt1 > 0; j1++, cnt1--)
			printf("%2d\t", j1);
		printf("\t");
		
		for(int j = 0; j < firstDay[1]; j++)
			printf("\t");
		cnt2 = 6 - (int)firstDay[1] + 1;
		for(j2 = 1; cnt2 > 0; j2++, cnt2--)
			printf("%2d\t", j2);
		printf("\t");
		
		for(int j = 0; j < firstDay[2]; j++)
			printf("\t");
		cnt3 = 6 - (int)firstDay[2] + 1;
		for(j3 = 1; cnt3 > 0; j3++, cnt3--)
			printf("%2d\t", j3);
		printf("\n");
		
		//第二次
		cnt1 = cnt2 = cnt3 = 7;
		for(; cnt1 > 0; cnt1--, j1++)
			printf("%2d\t", j1);
		printf("\t");
		for(; cnt2 > 0; cnt2--, j2++)
			printf("%2d\t", j2);
		printf("\t");
		for(; cnt3 > 0; cnt3--, j3++)
			printf("%2d\t", j3);
		printf("\n");
		
		//第三次
		cnt1 = cnt2 = cnt3 = 7;
		for(; cnt1 > 0; cnt1--, j1++)
			printf("%2d\t", j1);
		printf("\t");
		for(; cnt2 > 0; cnt2--, j2++)
			printf("%2d\t", j2);
		printf("\t");
		for(; cnt3 > 0; cnt3--, j3++)
			printf("%2d\t", j3);
		printf("\n");
		
		//第4次
		cnt1 = cnt2 = cnt3 = 7;
		for(; cnt1 > 0; cnt1--, j1++)
			printf("%2d\t", j1);
		printf("\t");
		for(; cnt2 > 0; cnt2--, j2++)
			printf("%2d\t", j2);
		printf("\t");
		for(; cnt3 > 0; cnt3--, j3++)
			printf("%2d\t", j3);
		printf("\n");
		
		//第5次
		int remain1, remain2, remain3;
		remain1 = remain2 = remain3 = 0;
		cnt1 = MonthLength[i] - j1 + 1;
		if(cnt1 > 7)
		{
			remain1 = cnt1 - 7;
			cnt1  = 7;
		}
		cnt2 = MonthLength[i+1] - j2 + 1;
		if(cnt2 > 7)
		{
			remain2 = cnt2 - 7;
			cnt2  = 7;
		}
		cnt3 = MonthLength[i+2] - j3 + 1;
		if(cnt3 > 7)
		{
			remain3 = cnt3 - 7;
			cnt3  = 7;
		}
		for(; cnt1 > 0; cnt1--, j1++)
			printf("%2d\t", j1);
		//补空
		if(remain1 == 0)
		{
			int fill1 = 5 * 7 - (int)(MonthLength[i] + firstDay[0]);
			for(int j = 0; j < fill1; j++)
				printf("  \t");
		}
		printf("\t");
		
		for(; cnt2 > 0; cnt2--, j2++)
			printf("%2d\t", j2);
		//补空
		if(remain2 == 0)
		{
			int fill2 = 5 * 7 - (int)(MonthLength[i+1] + firstDay[1]);
			for(int j = 0; j < fill2; j++)
				printf("  \t");
			
		}
		printf("\t");
		
		for(; cnt3 > 0; cnt3--, j3++)
			printf("%2d\t", j3);
		//补空
		if (remain3 == 0)
		{
			int fill3 = 5 * 7 - (int)(MonthLength[i+2] + firstDay[2]);
			for(int j = 0; j < fill3; j++)
				printf("  \t");
		}
		printf("\n");
		
		//最后一次
		if(remain1 != 0 || remain2 != 0 || remain3 != 0)
		{
			int fill1 = 7 - remain1;
			int fill2 = 7 - remain2;
			int fill3 = 7 - remain3;
			for(; remain1 > 0; remain1--, j1++)
				printf("%2d\t", j1);
			for(;fill1 > 0; fill1--)
				printf("  \t");
			printf("\t");
			
			for(; remain2 > 0; remain2--, j2++)
				printf("%2d\t", j2);
			for(;fill2 > 0; fill2--)
				printf("  \t");
			printf("\t");
			
			for(; remain3 > 0; remain3--, j3++)
				printf("%2d\t", j3);
			for(;fill3 > 0; fill3--)
				printf("  \t");
			printf("\n");
		}
	}
}
//打印3个月份
- (void) printThreeMonth : (NSUInteger)i
{
	NSArray *monthList = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
						   @"九月", @"十月", @"十一月", @"十二月"];
	if(i == 9)
	{
		NSLog(@"            十月 \t                       十一月\t\t                       十二月");
	}
	else
		NSLog(@"            %@ \t                        %@\t\t                        %@",
			  monthList[i], monthList[i + 1], monthList[i + 2]);
	NSLog(@"日\t一\t二\t三\t四\t五\t六\t\t日\t一\t二\t三\t四\t五\t六\t\t日\t一\t二\t三\t四\t五\t六");
}
@end
