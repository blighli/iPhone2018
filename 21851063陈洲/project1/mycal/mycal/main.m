/*
 
    陈洲
    project1
    2018/10/22
 
 */


#import <Foundation/Foundation.h>

char *monthName[13] = {"","一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
int monthDayNum[13] = {-1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char *day4Week[8] = {"","日", "一", "二", "三", "四", "五", "六"};


//验证月参数
bool validMonth(int month){

    return month<=12&&month>=1;

}

//验证年参数
bool validYear(int year){
    
    return year>0;
    
}

//验证闰年
bool isLeapYear(int year){
    
    return  ( (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 );
    
}

//根据日期获取星期名
int getWeekName(int year,int month,int day){
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * dateStr = [NSString stringWithFormat:@"%d-%d-%d", year, month,day ];

    NSDate *date = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    
    int ww = (int)[components weekday];
    return ww;
}

//输出单月日历
void monthCalendar(int month,int year){
    printf("  %s %4d\n", monthName[month], year);
    for (int i = 1; i <= 7; i++) {
        printf("%s ", day4Week[i]);
    }
    printf("\n");
    
    if(month==2){
        if(isLeapYear(year))
            monthDayNum[2]+=1;
    }
    
    
    int firstDayWeek = getWeekName(year,month,1);
    for (int i = 1; i < firstDayWeek; i++) {
        printf("   ");
    }
    
    for (int i = 1; i <= monthDayNum[month]; i++) {
        if (firstDayWeek == 8) {
            firstDayWeek = 1;
        }
        firstDayWeek += 1;
        printf("%2d", i);
        if (firstDayWeek != 8) {
            printf(" ");
        }
        else if (i != monthDayNum[month]) {
            printf("\n");
        }
    }
    printf("\n");
}

//输出三个月的日历
void multiMonthCalendar(int year,int beginMonth,int endMonth){
    
   
    //打印标题
    for (int i = beginMonth; i <= endMonth; i++) {
        if (i != beginMonth) {
            printf("             ");
        }
        printf("     %s     ", monthName[i]);
    }
    
    printf("\n");

    //打印星期栏
    for (int i = beginMonth; i <= endMonth; i++) {
        if (i != beginMonth) {
                printf("   ");
        }
        for (int j = 1; j <= 7; j++) {
            printf("%s ", day4Week[j]);
        }
    }
    
    printf("\n");
    if(isLeapYear(year))
        monthDayNum[2]+=1;
    
    int days[3];
    for(int i=0;i<3;i++){
        days[i] = 1;
    }
    int firstDay[3];
    for(int i=0; i<3; i++){
        firstDay[i] =getWeekName(year,beginMonth+i,1);
    }
    
    for(int i=0; i<6; i++){
        
        for(int k=0; k<3; k++){
            
            for(int j=1; j<=7; j++){
            
                if((i==0&&j<firstDay[k])||days[k]>monthDayNum[beginMonth+k]){
                    printf("   ");
                }else{
                    
                    printf("%2d ",days[k]);
                    days[k]+=1;
                    
                }
                
            
            }
            printf("   ");
        
        
        }
        printf("\n");
    }
}

//输出单年的日历
void printYearCalendar(int year){
    for (int i = 0; i < 31; i++) {
        printf(" ");
    }
    printf("%4d\n\n", year);
    for(int i=0;i<4; i++){
        multiMonthCalendar(year,i*3+1,i*3+3);
    }
}






int main(int argc, const char * argv[]) {
    
    //自动内存管理
    @autoreleasepool {
        
        
        
        //当前时间
        NSDate *currentDate = [NSDate date];
        //当前用户calendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //时间格式
        NSDateComponents * components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];


        int month = (int)[components month];
        int year = (int)[components year];
        
        if(argc==1){
            monthCalendar(month,year);
            return 0;
        }
        
        if(argc ==3){
            if(strcmp(argv[1], "-m")==0&&strspn(argv[2], "0123456789")==strlen(argv[2])){
                month = atoi(argv[2]);
                if(validMonth(month)){
                    monthCalendar(year,month);
                    return 0;
                }
            }else if(strspn(argv[1], "0123456789")==strlen(argv[1])){
                if(strspn(argv[2], "0123456789")==strlen(argv[2])){
                    year = atoi(argv[2]);
                    month=atoi(argv[1]);
                    if(validYear(year)&&validMonth(month)){
                        monthCalendar(month, year);
                        return 0;
                    }
                }
            }
            
        }
        if(argc==2){
            if(strspn(argv[1], "0123456789")==strlen(argv[1])){
                year = atoi(argv[1]);
                if(validYear(year)){
                    printYearCalendar(year);
                    return 0;
                }
            }
            
        }
        printf("cal: ");
        for(int i=0; i<argc;i++)
            printf(" %s",argv[i]);
        printf(" is not a valid command \n");
        printf("usage:\n");
        printf("    cal\n");
        printf("    cal -m [month]\n");
        printf("    cal [month] [year]\n");
        printf("    cal [year]\n");
        
    }
    return 0;
}


