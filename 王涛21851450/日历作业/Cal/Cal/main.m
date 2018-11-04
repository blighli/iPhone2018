//
//  main.m
//  Cal
//
//  Created by shayue on 2018/10/11.
//  Copyright © 2018 shayue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Solution.h"

bool isCorrectMonth(int *inputMonth, const char *p)			//判断输入的month是不是合法,要求month是正整数,[1,12]
{
	int len = 0;
	for(int i = 0; p[i] != '\0'; i++)
	{
		len++;
		if(len > 2)
			return false;
		if(p[i] < '0' || p[i] > '9')
			return false;
		*inputMonth = (p[i] - '0') + (*inputMonth) * 10;
	}
	if(*inputMonth == 0 || *inputMonth > 12)
		return false;
	else
		return true;
}

bool isCorrectYear(int *inputYear, const char *p)			//判断输入的year是不是合法,要求year是正整数, [1,9999]
{
	int len = 0;
	for(int i = 0; p[i] != '\0'; i++)
	{
		len++;
		if(len > 4)
			return false;
		if(p[i] < '0' || p[i] > '9')
			return false;
		*inputYear = (p[i] - '0') + (*inputYear) * 10;
	}
	if(*inputYear == 0)
		return false;
	else
		return true;
}

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		/***实例化对象***/
		Solution *solve = [[Solution alloc]init];
		NSDate *queryTime;
		
		/***命令行处理***/
		if(argc == 1)					//满足命令cal, 要求输出当前月的日历
		{
			queryTime = [NSDate date];
			[solve printOneMonthInterface:queryTime :true];
		}
		else if(argc == 2)				//满足命令cal year,要求输出整年的日历
		{
			int inputYear = 0;
			if(!isCorrectYear(&inputYear, argv[1]))		//判断输入的参数是否合法
			{
				printf("year '%s' not in range 1..9999\n", argv[1]);
			}
			else			//格式化输出
			{
				[solve printAllYear:inputYear];
			}
		}
		else if(argc == 3)				//满足命令cal -m month或者cal month year
		{
			int inputMonth = 0;
			if(argv[1][0] == '-' && argv[1][1] == 'm' && argv[1][2] == '\0')
			{
				if(!isCorrectMonth(&inputMonth, argv[2]))
				{
					printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
				}else
				{
					inputMonth -= 1;
					NSDate *tmp = [NSDate date];
					NSUInteger tmpYear = [solve getYear:tmp];
					queryTime = [solve getSetDate:tmpYear
									 :inputMonth ];
					[solve printOneMonthInterface:queryTime :false];
				}
			}
			else if(isCorrectMonth(&inputMonth, argv[1]))
			{
				int inputYear = 0;
				if( isCorrectYear(&inputYear, argv[2]))
				{
					inputMonth -= 1;
					queryTime = [solve getSetDate:inputYear
												 :inputMonth ];
					[solve printOneMonthInterface:queryTime :false];
				}else
					printf("year '%s' not in range 1..9999\n", argv[2]);
			}
			else
			{
				printf("%s is neither a month number (1..12) nor a name\n",argv[1]);
			}
		}
	}
	return 0;
}

