

#import <Foundation/Foundation.h>
#import "GetYearAndMonthOfToday.h"
#import "Judge.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc != 1&&argc!= 2&&argc != 3){
            printf("参数不对,请重来\n");
            return 0;
        }
        //./main cal
        if(argc == 1){
            NSString *strA = [NSString stringWithUTF8String:argv[0]];
            if([strA isNotEqualTo:@"cal"]&&[strA isNotEqualTo:@"./cal"]){
                printf("参数不对,请重来\n");
                return 0;
            }else{
                NSDate *date = [NSDate date];
                GetYearAndMonthOfToday *getyearandmonthoftoday = [GetYearAndMonthOfToday new];
                NSInteger month = [getyearandmonthoftoday getMonth:date];
                NSInteger year = [getyearandmonthoftoday getYear:date];
               
                NSInteger weekday = [getyearandmonthoftoday getWeekday:date]-2;
                if(weekday == -1) weekday = 6;
                NSInteger daysinmonth = [getyearandmonthoftoday getDaysInMonth:year month:month];
                printf("        %ld年%ld月\n",year,month);
                printf("日  一  二  三  四  五  六\n");
                NSInteger line = 5;
                if(weekday == 6||weekday == 5) line = 6;

                NSInteger column = 7;
                NSInteger countofdays = 1;
                for(int i = 0;i<line;i++){
                    for(int j = 0;j<column;j++){
                        if(i==0&j<weekday){
                            printf("    ");
                        }else if(countofdays <10){
                            printf("%ld   ",countofdays);
                            countofdays +=1;
                        }else if (countofdays >daysinmonth){
                            printf("    ");
                        }else{
                            printf("%ld  ",countofdays);
                            countofdays +=1;
                        }
                    }
                    printf("\n");

                }
            }

        }
        //./main cal 2018
        
        if(argc == 2){
            NSString *strA = [NSString stringWithUTF8String:argv[0]];
            NSString *strB = [NSString stringWithUTF8String:argv[1]];
            NSInteger numB;
            Judge *judge = [Judge new];
            BOOL judgenumB = [judge isAllNum:strB];
            
            if([strA isNotEqualTo:@"cal"]&&[strA isNotEqualTo:@"./cal"]){
                printf("参数不对,请重来\n");
                return 0;
            }else if(judgenumB){
                numB = [strB integerValue];

                if(numB<=0){
                    printf("参数不对,请重来\n");
                    return 0;
                }
                for(int m = 1;m<13;m++){
                    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
                    [dateformat setDateFormat:@"yyyy-MM-dd"];
                    GetYearAndMonthOfToday *getyearandmonthoftoday = [GetYearAndMonthOfToday new];
                        NSDate *date1 = [NSDate date];
                    NSInteger getday = [getyearandmonthoftoday getDay:date1];
                    NSString *string = [NSString stringWithFormat:@"%ld-%d-%ld",numB,m,getday];
                    
                    NSDate *date = [dateformat dateFromString:string];
                    NSInteger month = [getyearandmonthoftoday getMonth:date];
                    NSInteger year = [getyearandmonthoftoday getYear:date];
                    NSInteger weekday = [getyearandmonthoftoday getWeekday:date]-2;
                    if(weekday == -1) weekday = 6;
                    NSInteger daysinmonth = [getyearandmonthoftoday getDaysInMonth:year month:month];
                    printf("        %ld年%ld月\n",year,month);
                    printf("日  一  二  三  四  五  六\n");
                    NSInteger line = 5;
                    NSInteger column = 7;
                    if(weekday == 6||weekday == 5) line = 6;
                    NSInteger countofdays = 1;
                    for(int i = 0;i<line;i++){
                        for(int j = 0;j<column;j++){
                            if(i==0&j<weekday){
                                printf("    ");
                            }else if(countofdays <10){
                                printf("%ld   ",countofdays);
                                countofdays +=1;
                            }else if (countofdays >daysinmonth){
                                printf("    ");
                            }else{
                                printf("%ld  ",countofdays);
                                countofdays +=1;
                            }
                        }
                        printf("\n");
                        
                    }
                }
            }else{
                printf("参数不对,请重来\n");
                return 0;
            }
            
        }
        
        
        
        //./main cal -m 10 ;./main cal 10 2018
        if(argc == 3){
            
            NSString *strA = [NSString stringWithUTF8String:argv[0]];
            NSString *strB = [NSString stringWithUTF8String:argv[1]];
            NSString *strC = [NSString stringWithUTF8String:argv[2]];
            NSInteger numC,numB;
            if([strA isNotEqualTo:@"cal"]&&[strA isNotEqualTo:@"./cal"]){
                printf("参数不对,请重来\n");
                return 0;
            }
            Judge *judge = [Judge new];
            BOOL judgenumB = [judge isAllNum:strB];
            BOOL judgenumC = [judge isAllNum:strC];
            if(judgenumC){
            numC = [strC integerValue];
                if(numC<=0){
                    printf("参数不对,请重来\n");
                    return 0;
                }
            }else {
                printf("参数不对,请重来\n");
                return 0;
            }
            if(judgenumB){
            numB = [strB integerValue];
                if(numB>=13||numB<=0){
                    printf("参数不对,请重来\n");
                    return 0;
                }
                if(numB<13&&numB>0){
                    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
                    [dateformat setDateFormat:@"yyyy-MM-dd"];
                    NSDate *date1 = [NSDate date];
                    GetYearAndMonthOfToday *getyearandmonthoftoday = [GetYearAndMonthOfToday new];


                    NSInteger getday = [getyearandmonthoftoday getDay:date1];

                    NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld",numC,numB,getday];
                    NSDate *date = [dateformat dateFromString:string];
                    NSInteger month = [getyearandmonthoftoday getMonth:date];

                    NSInteger year = [getyearandmonthoftoday getYear:date];
                    
//                NSInteger weekday = [getyearandmonthoftoday getWeekday:date]-2;
                    NSInteger weekday = [getyearandmonthoftoday getWeekday:date]-2;
                    if(weekday == -1) weekday = 6;

                    NSInteger daysinmonth = [getyearandmonthoftoday getDaysInMonth:year month:month];
                    printf("        %ld年%ld月\n",year,month);
                    printf("日  一  二  三  四  五  六\n");
                    NSInteger line = 5;
                    if(weekday == 6||weekday == 5) line = 6;

                    NSInteger column = 7;
                    NSInteger countofdays = 1;
                    for(int i = 0;i<line;i++){
                        for(int j = 0;j<column;j++){
                            if(i==0&j<weekday){
                                printf("    ");
                            }else if(countofdays <10){
                                printf("%ld   ",countofdays);
                                countofdays +=1;
                            }else if (countofdays >daysinmonth){
                                printf("    ");
                            }else{
                                printf("%ld  ",countofdays);
                                countofdays +=1;
                            }
                        }
                        printf("\n");
                        
                    }
                
                    
                    
                }
                
            }else if([strB isNotEqualTo:@"-m"]||numC>12||numC<= 0){
                printf("参数不对,请重来\n");
                return 0;
            } else {
                NSDate *date1 = [NSDate date];
                GetYearAndMonthOfToday *getyearandmonthoftoday1 = [GetYearAndMonthOfToday new];
                NSInteger year1 = [getyearandmonthoftoday1 getYear:date1];
                GetYearAndMonthOfToday *getyearandmonthoftoday = [GetYearAndMonthOfToday new];
                
                
                NSInteger getday = [getyearandmonthoftoday getDay:date1];
                NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
                [dateformat setDateFormat:@"yyyy-MM-dd"];
                NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld",year1,numC,getday];
                NSDate *date = [dateformat dateFromString:string];
                NSInteger month = [getyearandmonthoftoday getMonth:date];
                NSInteger year = [getyearandmonthoftoday getYear:date];
                
                NSInteger weekday = [getyearandmonthoftoday getWeekday:date]-2;
                if(weekday == -1) weekday = 6;

                NSInteger daysinmonth = [getyearandmonthoftoday getDaysInMonth:year month:month];
                printf("        %ld年%ld月\n",year,month);
                printf("日  一  二  三  四  五  六\n");
                NSInteger line = 5;
                if(weekday == 6||weekday == 5) line = 6;

                NSInteger column = 7;
                NSInteger countofdays = 1;
                for(int i = 0;i<line;i++){
                    for(int j = 0;j<column;j++){
                        if(i==0&j<weekday){
                            printf("    ");
                        }else if(countofdays <10){
                            printf("%ld   ",countofdays);
                            countofdays +=1;
                        }else if (countofdays >daysinmonth){
                            printf("    ");
                        }else{
                            printf("%ld  ",countofdays);
                            countofdays +=1;
                        }
                    }
                    printf("\n");
                    
                }
                
                
                
            }
        
            
            }

        }

    return 0;

    }

    
    




