//
//  JITArray.m
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITArray.h"


@implementation JITArray

+ (void)gOneMonthArray:(NSMutableArray *)arr
               inComps:(JITDateComponents *)comps
            isWithYear:(NSInteger)iYear
{
    // Add short weekday symbols to the array
    NSInteger count = 0;
    for(NSString *item in comps.calendar.shortWeekdaySymbols){
        [arr addObject:item];
        count ++;
    }
    // Add month day to the array;
    // blanks before the first day;
    comps.day = 1;
    NSInteger weekdayIndex = [JITInteger getWeekdayIndexFromComponents:comps];
    for(NSInteger j = 0; j < weekdayIndex - 1; j++){
        [arr addObject:@""];
        count ++;
    }
    for(NSInteger i = 1; i < 32; i++){
        /* All possible 31 days */
        comps.day = i;
        
        if(comps.validDate){
            /* Validations always comes first */
            
            // Convert the day(integer) to string
            NSString *day = [[NSString alloc] initWithFormat:@"%ld", i];
            
            [arr addObject:day];
            count ++;
        } // End of outter if
        
        else{
            // nothing happends
            
        }
    } // End of for
    
    NSString *header = [NSString alloc];
    
    if(iYear){
        header = [header initWithFormat:@"%@ %ld", comps.calendar.monthSymbols[comps.month - 1], comps.year];
    }
    else
        header = [header initWithFormat:@"%@", comps.calendar.monthSymbols[comps.month - 1]];
    [arr insertObject:header atIndex:0];
    count ++;
    
    for(int i = 0; i< COUNT - count; i++)
        [arr addObject:@" "];
    
}

+ (void)cOneMonthArray:(NSMutableArray *)arr
               inComps:(JITDateComponents *)comps
            isWithYear:(NSInteger)iYear
{
    NSInteger count = 0;
    // Add short weekday symbols to the array
    for(NSString *item in comps.calendar.shortWeekdaySymbols){
        [arr addObject:item];
        count ++;
    }
    // Add month day to the array;
    // blanks before the first day;
    comps.day = 1;
    NSInteger weekdayIndex = [JITInteger getWeekdayIndexFromComponents:comps];
    for(NSInteger j = 0; j < weekdayIndex - 1; j++){
        [arr addObject:@""];
        count ++;
    }
    for(NSInteger i = 1; i < 32; i++){
        /* All possible 31 days */
        comps.day = i;
        
        if(comps.validDate){
            /* Validations always comes first */
            
            // Convert the day(integer) to string
            JITDateComponents *cComps = [comps convertToChinese];
            NSString *day = [NSString alloc];
//            if(cComps.day == 1)
//                day = [day initWithFormat:@"%ld[%ld.%ld]", i, cComps.month, cComps.day];
//            else
//                day = [day initWithFormat:@"%ld[%ld]", i, cComps.day];
            
            if(cComps.day == 1)
                day = [day initWithFormat:@"%ld[%ld.%ld]", i, cComps.month, cComps.day];
            else
                day = [day initWithFormat:@"%ld[%ld]", i, cComps.day];
            
            // Add the day string to the array
            [arr addObject:day];
            count ++;
        } // End of outter if
        
        else{
            // nothing happends
            
        }
    } // End of for
    
    // Header
    NSString *header = [NSString alloc];
    
    NSArray *cYear = @[@"",
                       @"甲子鼠年", @"乙丑牛年", @"丙寅虎年", @"丁卯兔年", @"戊辰龙年", @"己巳蛇年", @"庚午马年", @"辛未羊年", @"壬申猴年", @"癸酉鸡年", @"甲戌狗年", @"乙亥猪年",
                       @"丙子鼠年", @"丁丑牛年", @"戊寅虎年", @"己卯兔年", @"庚辰龙年", @"辛巳蛇年", @"壬午马年", @"癸未羊年", @"甲申猴年", @"乙酉鸡年", @"丙戌狗年", @"丁亥猪年",
                       @"戊子鼠年", @"己丑牛年", @"庚寅虎年", @"辛卯兔年", @"壬辰龙年", @"癸巳蛇年", @"甲午马年", @"乙未羊年", @"丙申猴年", @"丁酉鸡年", @"戊戌狗年", @"己亥猪年",
                       @"庚子鼠年", @"辛丑牛年", @"壬寅虎年", @"癸卯兔年", @"甲辰龙年", @"乙巳蛇年", @"丙午马年", @"丁未羊年", @"戊申猴年", @"己酉鸡年", @"庚戌狗年", @"辛亥猪年",
                       @"壬子鼠年", @"癸丑牛年", @"甲寅虎年", @"乙卯兔年", @"丙辰龙年", @"丁巳蛇年", @"戊午马年", @"己未羊年", @"庚申猴年", @"辛酉鸡年", @"壬戌狗年", @"癸亥猪年"];
    
    
    JITDateComponents *temp = [comps convertToChinese];
    
    if(iYear)
        header = [header initWithFormat:@"%@ %ld(%@)", comps.calendar.monthSymbols[comps.month - 1], comps.year, cYear[temp.year]];
    else
        header = [header initWithFormat:@"%@", comps.calendar.monthSymbols[comps.month - 1]];
    [arr insertObject:header atIndex:0];
    count ++;
    
    for(int i = 0; i< COUNT - count; i++)
        [arr addObject:@" "];
}

+ (void)beautifyArray:(NSMutableArray *)arr
              inComps:(JITDateComponents *)comps
            withStyle:(NSInteger)style
{
    NSInteger maxLength = [JITInteger maxLengthInStrings:arr];
    
    NSInteger maxWidth = 7 * (maxLength + 1);
    NSString *header = arr[0];
    header = [JITString centerString:header withWidth:maxWidth];
    [arr replaceObjectAtIndex:0 withObject:header];
    
    
    for(NSInteger i = 1; i < [arr count]; i++){
        NSInteger length = [JITInteger stringLength:arr[i]];
        
        NSString *outString = [[NSString alloc] init];
        for(int i = 0; i < maxLength - length; i++){
            outString = [outString stringByAppendingString:@" "];
        }
        //outString = [JITDateOut beautifyString:outString];
        NSInteger dayNum = [JITInteger numberFromString:arr[i]];
        
        NSString *dayString = [JITString beautifyString:arr[i]
                                                withDay:dayNum
                                                inComps:comps
                                             withStyle:style];
        
        outString = [outString stringByAppendingString:dayString];
        
//        if((i % [comps.calendar.weekdaySymbols count] == 0) | (i == [arr count] - 1))
//            outString = [outString stringByAppendingString:@"\n"];
//        else
        outString = [outString stringByAppendingString:@" "];
        
        [arr replaceObjectAtIndex:i withObject:outString];
    }
    
}
+ (void)gAdjacentMonthArray:(NSMutableArray *)arr
                    inComps:(JITDateComponents *)comps
                 isWithYear:(NSInteger)iYear
{
    NSMutableArray *before = [[NSMutableArray alloc] init];
    NSMutableArray *current = [[NSMutableArray alloc] init];
    NSMutableArray *after = [[NSMutableArray alloc] init];
    NSInteger month = comps.month;
    NSInteger year = comps.year;
    
    
    [JITArray gOneMonthArray:current inComps:comps isWithYear:iYear];
    [JITArray beautifyArray:current
                    inComps:comps
                 withStyle:GREGORIAN];
    
    // Before month array
    if(month == 1){
        comps.month = 12;
        comps.year = year - 1;
        [JITArray gOneMonthArray:before inComps:comps isWithYear:iYear];
        
        // reset
        comps.year = year;
    }
    else{
        comps.month = month -1;
        [JITArray gOneMonthArray:before inComps:comps isWithYear:iYear];
    }
    
    [JITArray beautifyArray:before
                    inComps:comps
                 withStyle:GREGORIAN];
    
    // After month array
    if(month == 12){
        comps.month = 1;
        comps.year = year + 1;
        [JITArray gOneMonthArray:after inComps:comps isWithYear:iYear];
        
        // reset
        comps.year = year;
    }
    else{
        comps.month = month + 1;
        [JITArray gOneMonthArray:after inComps:comps isWithYear:iYear];
    }
    
    [JITArray beautifyArray:after
                    inComps:comps
                 withStyle:GREGORIAN];
    
    [arr addObjectsFromArray:before];
    [arr addObjectsFromArray:current];
    [arr addObjectsFromArray:after];
    //NSLog(@"%@", arr);
    
    
}

+ (void)cAdjacentMonthArray:(NSMutableArray *)arr
                    inComps:(JITDateComponents *)comps
                 isWithYear:(NSInteger)iYear
{
    
    NSMutableArray *before = [[NSMutableArray alloc] init];
    NSMutableArray *current = [[NSMutableArray alloc] init];
    //NSMutableArray *after = [[NSMutableArray alloc] init];
    NSInteger month = comps.month;
    NSInteger year = comps.year;
    
    [JITArray cOneMonthArray:current inComps:comps isWithYear:iYear];
    [JITArray beautifyArray:current
                    inComps:comps
                  withStyle:CHINESE];
    
    // Before month array
    if(month == 1){
        comps.month = 12;
        comps.year = year - 1;
        [JITArray cOneMonthArray:before inComps:comps isWithYear:iYear];
        
        // reset
        comps.year = year;
    }
    else{
        comps.month = month -1;
        [JITArray cOneMonthArray:before inComps:comps isWithYear:iYear];
    }
    
    [JITArray beautifyArray:before
                    inComps:comps
                  withStyle:CHINESE];
    
//    // After month array
//    if(month == 12){
//        comps.month = 1;
//        comps.year = year + 1;
//        [JITArray cOneMonthArray:after inComps:comps isWithYear:iYear];
//
//        // reset
//        comps.year = year;
//    }
//    else{
//        comps.month = month + 1;
//        [JITArray cOneMonthArray:after inComps:comps isWithYear:iYear];
//    }
//
//    [JITArray beautifyArray:after
//                    inComps:comps
//                  withStyle:CHINESE];
    
    [arr addObjectsFromArray:before];
    [arr addObjectsFromArray:current];
    //[arr addObjectsFromArray:after];
    //NSLog(@"%@", arr);
}
@end
