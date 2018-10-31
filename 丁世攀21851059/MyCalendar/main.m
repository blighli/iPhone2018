#import <Foundation/Foundation.h>

//判断输入是否合法
bool isNum(const char *str)
{
    for (int i = 0; i < strlen(str); i++)
        if (str[i] < '0' || str[i] > '9')
            return false;
    return true;
}
bool isMonth(NSUInteger month)
{
    return month >= 1 && month <= 12;
}
bool isYear(NSUInteger year)
{
    return year >= 1 && year <= 9999;
}
void printError(){
	NSLog(@"parameter is illegal!");
}

//输出日历
//times为每行中输出的月份日历的个数,times取1或3
void showCal(NSUInteger year, NSUInteger minMonth, NSUInteger maxMonth, NSUInteger times)
{

	/*
		输出标题
	*/
	
	char *numStr[] = {"", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"};
	
    if (times == 3)
    {
		//输出整年日历时，输出年份标题
		
		//计算年份前的空格
		NSUInteger spaceNum = times*20 + (times-1)*2;
		spaceNum = spaceNum/2 - 2;
		
		//输出年份前的空格
        for (int i = 0; i < spaceNum; i++) printf(" ");
		
		//格式化输出四位年份
        printf("%4lu\n\n", year);
    }
    else
    {
		//输出一个月的日历时，输出年份月份标题
        printf("     %s月 %4lu\n", numStr[minMonth], year);
    }
	
	/*
		计算工作日和月份包含的天数
	*/
	
	//获取当前用户的日历；NSCalendar对象封装了关于计算时间系统的信息，也就是历法信息。
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
	//NSDateComponents是封装了日期的组件，可以设置年月日等日期。它含有NSCalendar对象，并且可以根据NSCalendar日历对象解释封装的时间，以获取指定历法下某个日期的星期，某个月份的天数等信息。
    NSDateComponents *compt = [[NSDateComponents alloc] init];
   
	//获取当前年份每月的天数和每月的1号是星期几
    NSUInteger arrFirstDay[13]={0};//存储当前年份每月的第一天是星期几
    NSUInteger arrDayCount[13]={0};//存储当前年份每月有多少天
	
    for (NSUInteger month = minMonth; month <= maxMonth; month++)
    {
		//为NSDateComponents对象设置年月日
        [compt setYear:year];
        [compt setMonth:month];
        [compt setDay:1];
		
		//获取一个新的NSDate对象，表示在给定的NSCalendar对象上下文中，从NSDateComponents对象中计算出的绝对时间
        NSDate *date = [calendar dateFromComponents:compt];
		
		//根据NSCalendar和NSDate，获取包含weekday组件的NSDateComponents对象
		compt = [calendar components:NSCalendarUnitWeekday fromDate:date];
        NSUInteger week = [compt weekday];
		arrFirstDay[month] =week;
		
		//此方法返回一个更小的日历单元(例如一天)在一个更大的日历单元(例如一个月)中包含指定的绝对时间的绝对时间值的范围。
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        NSUInteger dayCount = range.length;
		
		//获取到当前月份的天数
        arrDayCount[month] = dayCount;
    }
	
	/*
		输出天数
	*/
	
	//存储每月中已经输出到了第几天
    NSUInteger cnt[12];	
	
    for (NSUInteger month = minMonth; month <= maxMonth; month += times)
    {
		if (maxMonth - month + 1 < times) times = maxMonth - month + 1;
		
		//输出整年日历时，输出月份标题
        if (minMonth != maxMonth)
        {
            for (int t = 0; t < times; t++)
            {
                if (month + t < 11)
                    printf("        %s月          ", numStr[month + t]);//输出1~10的月份标题
                else printf("       %s月         ", numStr[month + t]);//输出11，12月的月份标题
            }
            printf("\n");
        }
		
		//输出星期标题
        for (int t = 0; t < times; t++)
            printf("日 一 二 三 四 五 六  ");
        printf("\n");
			
		//初始化计数数组
		for (int i = 0; i < times; i++) cnt[i] = 1;
	
		//输出6行天数
		for (int i = 0; i < 6; i++)
        {
            for (int t = 0; t < times; t++)
            {
                NSUInteger st = 1;
				
				//输出1号前的空格
                if (i == 0)
                {
                    for (int j = 1; j < arrFirstDay[month + t]; j++)
                    {
                        printf("   ");
                    }
                    st = arrFirstDay[month + t];
                }
				
				//输出一行
                for (NSUInteger j = st; j <= 7; j++)
                {
                    if (j == 1 || cnt[t] == 1)
                    {
						//本月已经输出完，当前行中的其它月还没有输出完天数，所以输出空格占位
                        if (cnt[t] > arrDayCount[month + t])
                        {
                            printf("  ");
                        }
                        else printf("%2lu", cnt[t]++);
                    }
                    else
                    {
                        if (cnt[t] > arrDayCount[month + t])
                        {
                            printf("   ");
                        }
                        else printf("%3lu", cnt[t]++);
                    }
					//输出七次后，判断继续输出还是换行结束
                    if (j == 7)
                    {
                        if (t == times - 1) printf("\n");
                        else printf("  ");
                    }
                }
            }
        }
    }
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {

		//创建NSCalendar上下文对象
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
		//获取当前年和月
        NSUInteger unFlag = (NSCalendarUnitYear|NSCalendarUnitMonth);
        NSDateComponents *compt = [calendar components:unFlag fromDate:date];
        NSUInteger month = [compt month];
        NSUInteger year = [compt year];
		
		//执行“cal”命令
		if (argc == 1)
			showCal(year, month, month, 1);
		else
		{
			//执行“cal -m 10”命令
			if (argv[1][0] == '-')
			{
				//输入校验
				int flag=0;
				if (argv[1][1] == 'm' && argc == 3 && isNum(argv[2])){
					month = atoi(argv[2]);
					if (!isMonth(month)) flag=1;
				}
				else 
					flag=1;
				
				if(flag) printError();
				else showCal(year, month, month, 1);
			}
			else
			{
				//输入校验
				int flag=0;
				for (int i = 1; i < argc; i++)
					if (!isNum(argv[i]))
						flag=1;
					
				if(flag)
					printError();
				else{
					//执行“cal 10 2018”命令
					if (argc == 3)
					{
						//输入校验
						month = atoi(argv[1]);
						year = atoi(argv[2]);
						if (!isMonth(month)||!isYear(year))
							printError();
						else
							showCal(year, month, month, 1);
					}
					//执行“cal 2018”命令
					else if (argc == 2)
					{
						//输入校验
						year = atoi(argv[1]);
						if (!isYear(year))
							printError();
						else
							showCal(year, 1, 12, 3);
					}
					else
					{
						printError();
					}
				}
			}
		}
    }
    return 0;
}