//
//  main.m
//  iPhomework1
//
//  Created by 金徳一 on 2018/10/23.
//  Copyright © 2018 Jdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string.h>
int daylist1[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int daylist2[12]={31,29,31,30,31,30,31,31,30,31,30,31};
char *weekdays1="日  一 二  三 四 五  六";
char *weekdays3="日  一 二  三 四 五  六   日  一 二 三 四  五 六   日  一 二  三 四  五 六";
char *monthlist1[12]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
char *monthlist3[12]={
    "         一月                    二月                    三月",
    "         四月                    五月                    六月",
    "         七月                    八月                    九月",
    "         十月                   十一月                   十二月"};
int nowMonth(){  //现在的月份
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    int unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *comp=[cal components:unitFlags fromDate:now];
    int month=(int)[comp month];
    return month;
}

int nowYear(){  //现在的年份
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    int unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *comp=[cal components:unitFlags fromDate:now];
    int year=(int)[comp year];
    return year;
}

int firstWeekday(int year,int month){  //每个月的第一天是周几 0是周日
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDateComponents *thisComp=[[NSDateComponents alloc]init];
    int unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    [thisComp setYear:year];
    [thisComp setMonth:month];
    [thisComp setDay:1];
    NSDate *thisDay=[cal dateFromComponents:thisComp];
    NSDateComponents *comp=[cal components:unitFlags fromDate:thisDay];
    return (int)[comp weekday];
}
BOOL isLeapYear(int year){
    if ((year%4==0&&year%100) || year%400==0) return true;
    else return false;
}
void calMonth(int *a,int year,int month){ //(calculate)计算一个月历，保存到数组a[]，便于格式化输出
    int dayNum; //一个月多少天
    if (isLeapYear(year))
        dayNum=daylist2[month-1];
    else dayNum=daylist1[month-1];
    int firstday=firstWeekday(year, month);
    for(int i=0;i<firstday+dayNum-1;i++){ //exp.31天中 第一天是星期一（=2） i<32 故数组中第1个a[0]以-1记 ; 第2(a[1])～32(a[31])记1～31
        if(i<firstday-1) a[i]=-1;
        else a[i]=i-firstday+2;
    }
}
void printMonth(int *a,int year,int month){ //将数组中的日历 格式化输出
    printf("     %s  %d\n",monthlist1[month-1],year);
    printf("%s\n",weekdays1);
    int i=0;
    while(a[i]!=0){
        if(a[i]==-1) printf("   ");
        else {
            if(a[i]<10) printf(" %d ",a[i]);
            else printf("%d ",a[i]);
        }
        if((i+1)%7==0) printf("\n");
        i++;
    }
    printf("\n");
};
void calendarOneMonth(int year,int month){
    int a[50]={0};
    calMonth(a, year, month);
    printMonth(a, year, month);
}
void printThreeMonth(int a[][50],int month1){ //将同行三个月的月历数组格式化输出
    printf("%s\n",monthlist3[(month1-1)/3]);
    printf("%s\n",weekdays3);
    int i=0,j=0,cnt=0;
    //while(a[0][cnt*7]!=0 ||a[1][cnt*7]!=0 ||a[2][cnt*7]!=0){
    while(cnt<7){ //固定输出7行
        for(i=0;i<3;i++){
            for(j=cnt*7;j<cnt*7+7;j++){
                if(a[i][j]<=0) printf("   ");
                else{
                    if(a[i][j]<10) printf(" %d ",a[i][j]);
                    else printf("%d ",a[i][j]);
                }
            }
            printf("  ");
        }
        printf("\n");
        cnt++;
    }
}
void calendarYear(int year){
    for(int i=0;i<32;i++) printf(" ");
    printf("%d\n",year);
    int a[12][50]={0};//特别注意！！一个月最多可以表示成7行，所以每个月至少需要7*7=49的数组大小；初始化0
    for(int i=0;i<4;i++){
        for(int j=i*3;j<i*3+3;j++){ //month=j+1
            calMonth(a[j], year, j+1);
        }
        printThreeMonth(&a[i*3], i*3+1);
    }
}
int stringToNum(char *a){
    int i=0;
    int num=0;
    while(a[i]!=0){
        num*=10;
        num+=a[i]-'0';
        i++;
    }
    return num;
}
BOOL isNum(char* a){ //判定此字符串是否为纯数字
    int i=0;
    int flag=1;
    while(a[i]){
        if(a[i]<'0'||a[i]>'9') flag=0;
        i++;
    }
    return flag;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char input[100];
        char cmd[100];
        char x1[100];
        char x2[100];
        gets(input);   //这两行输入代码是参考同学的，不是特别明白用法
        sscanf(input,"%s %s %s",cmd,x1,x2);
        if(strcmp(cmd, "cal")){
            printf("command not found\n");
        }
        else{  //不仅要对x1x2是否存在进行判定，也要对n1n2进行范围判定
            int n1=stringToNum(x1);
            int n2=stringToNum(x2);
            if (x1[0]==0&&x2[0]==0){ //this month
                calendarOneMonth(nowYear(), nowMonth());
            }
            else {
                if(!isNum(x1)){ //x1不为纯数字
                    if(!strcmp(x1,"-m") &&x2[0] && n2<=12&&n2>=1){ //-m month, x1=-m时必须有参数x2否则无效
                        calendarOneMonth(nowYear(),n2);
                    }
                    else printf("invalid input\n");
                }
                else if(n1>=1&&n1<=12&&n2>=0 &&x1[0]&&x2[0]){ //month year
                    calendarOneMonth(n2, n1);
                }
                else if(n1>=0&& x2[0]==0){ //year
                    calendarYear(n1);
                }
                //无效输入集
                //cal asd (xxxx)
                //cal -m 0/13
                //cal 0/13 2018
                //cal 1 -1
                //cal -1
                else printf("invalid input\n");
            }
        }
    }
    return 0;
}

