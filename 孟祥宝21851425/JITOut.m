//
//  JITOut.m
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITOut.h"

@implementation JITOut
+ (void)gOneMonthOut:(JITDateComponents *)comps
          isWithYear:(NSInteger)iYear
{
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    [JITArray gOneMonthArray:outArray
                     inComps:comps isWithYear:iYear];
    
    [JITArray beautifyArray:outArray inComps:comps withStyle:GREGORIAN];
    // It's time to "connect" the array to a string
    NSString *outString = [JITString formStringFromArray:outArray];
    
//    NSInteger width = [JITInteger maxWidthOfString:outString];
//    NSString *header = [[NSString alloc] initWithFormat:@"%ld", comps.year];
//    header = [JITString centerString:header withWidth:width];
    fprintf(stdout, "\n%s", [outString UTF8String]);
}
+ (void)cOneMonthOut:(JITDateComponents *)comps
          isWithYear:(NSInteger)iYear
{
    
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    [JITArray cOneMonthArray:outArray
                     inComps:comps isWithYear:iYear];
    // It's time to "connect" the array to a string
    [JITArray beautifyArray:outArray inComps:comps withStyle:CHINESE];
    
    NSString *outS = [JITString formStringFromArray:outArray];
//    NSInteger width = [JITInteger maxWidthOfString:outS];
//    NSString *header1 = [[NSString alloc] initWithFormat:@"%ld", comps.year];
//    NSArray *cYear = @[@"",
//                       @"甲子鼠年", @"乙丑牛年", @"丙寅虎年", @"丁卯兔年", @"戊辰龙年", @"己巳蛇年", @"庚午马年", @"辛未羊年", @"壬申猴年", @"癸酉鸡年", @"甲戌狗年", @"乙亥猪年",
//                       @"丙子鼠年", @"丁丑牛年", @"戊寅虎年", @"己卯兔年", @"庚辰龙年", @"辛巳蛇年", @"壬午马年", @"癸未羊年", @"甲申猴年", @"乙酉鸡年", @"丙戌狗年", @"丁亥猪年",
//                       @"戊子鼠年", @"己丑牛年", @"庚寅虎年", @"辛卯兔年", @"壬辰龙年", @"癸巳蛇年", @"甲午马年", @"乙未羊年", @"丙申猴年", @"丁酉鸡年", @"戊戌狗年", @"己亥猪年",
//                       @"庚子鼠年", @"辛丑牛年", @"壬寅虎年", @"癸卯兔年", @"甲辰龙年", @"乙巳蛇年", @"丙午马年", @"丁未羊年", @"戊申猴年", @"己酉鸡年", @"庚戌狗年", @"辛亥猪年",
//                       @"壬子鼠年", @"癸丑牛年", @"甲寅虎年", @"乙卯兔年", @"丙辰龙年", @"丁巳蛇年", @"戊午马年", @"己未羊年", @"庚申猴年", @"辛酉鸡年", @"壬戌狗年", @"癸亥猪年"];
//
//
//    JITDateComponents *temp = [comps convertToChinese];
//    NSString *header2 = [[NSString alloc] initWithFormat:@"%@", cYear[temp.year]];
//
//    header1 = [JITString centerString:header1 withWidth:width];
//    header2 = [JITString centerString:header2 withWidth:width];
    fprintf(stdout, "\n%s", [outS UTF8String]);
}

+ (void)gAdjacentMonthsOut:(JITDateComponents *)comps
              isWithHeader:(NSInteger)iHeader
{
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    if(comps.month == 1 || comps.month == 12){
        [JITArray gAdjacentMonthArray:outArray inComps:comps isWithYear:WITHYEAR];
        iHeader = WITHOUTHEADER;
    }
    else
        [JITArray gAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    NSString *outS = [JITString formStringFromArray:outArray];
    NSInteger width = [JITInteger maxWidthOfString:outS];
    NSString *header = [[NSString alloc] initWithFormat:@"%ld", comps.year];
    header = [JITString centerString:header withWidth:width];
    if(iHeader)
        fprintf(stdout, "\n%s\n%s", [header UTF8String], [outS UTF8String]);
    else
        fprintf(stdout, "\n%s", [outS UTF8String]);
}

+ (void)cAdjacentMonthsOut:(JITDateComponents *)comps
              isWithHeader:(NSInteger)iHeader
{
//    NSMutableArray *outArray = [[NSMutableArray alloc] init];
//    if(comps.month == 1 || comps.month == 12){
//        [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHYEAR];
//        iHeader = NOHEADER;
//    }
//    else
//        [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
//    NSString *outS = [JITString formStringFromArray:outArray];
//    NSInteger width = [JITInteger maxWidthOfString:outS];
//    NSString *header1 = [[NSString alloc] initWithFormat:@"%ld", comps.year];
//    NSArray *cYear = @[@"",
//                       @"甲子鼠年", @"乙丑牛年", @"丙寅虎年", @"丁卯兔年", @"戊辰龙年", @"己巳蛇年", @"庚午马年", @"辛未羊年", @"壬申猴年", @"癸酉鸡年", @"甲戌狗年", @"乙亥猪年",
//                       @"丙子鼠年", @"丁丑牛年", @"戊寅虎年", @"己卯兔年", @"庚辰龙年", @"辛巳蛇年", @"壬午马年", @"癸未羊年", @"甲申猴年", @"乙酉鸡年", @"丙戌狗年", @"丁亥猪年",
//                       @"戊子鼠年", @"己丑牛年", @"庚寅虎年", @"辛卯兔年", @"壬辰龙年", @"癸巳蛇年", @"甲午马年", @"乙未羊年", @"丙申猴年", @"丁酉鸡年", @"戊戌狗年", @"己亥猪年",
//                       @"庚子鼠年", @"辛丑牛年", @"壬寅虎年", @"癸卯兔年", @"甲辰龙年", @"乙巳蛇年", @"丙午马年", @"丁未羊年", @"戊申猴年", @"己酉鸡年", @"庚戌狗年", @"辛亥猪年",
//                       @"壬子鼠年", @"癸丑牛年", @"甲寅虎年", @"乙卯兔年", @"丙辰龙年", @"丁巳蛇年", @"戊午马年", @"己未羊年", @"庚申猴年", @"辛酉鸡年", @"壬戌狗年", @"癸亥猪年"];
//
//
//    JITDateComponents *temp = [comps convertToChinese];
//    NSString *header2 = [[NSString alloc] initWithFormat:@"%@", cYear[temp.year]];
//
//    header1 = [JITString centerString:header1 withWidth:width];
//    header2 = [JITString centerString:header2 withWidth:width];
//
//
//    if(iHeader)
//        fprintf(stdout, "\n%s\n%s\n%s", [header1 UTF8String], [header2 UTF8String], [outS UTF8String]);
//    else
//        fprintf(stdout, "\n%s", [outS UTF8String]);
    
    NSInteger month = comps.month;
    NSInteger year = comps.year;
    
    if(month == 1){
        // before
        comps.month = 12;
        comps.year = year - 1;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
        
        comps.month = month;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
        
        comps.month = month + 1;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
    }
    else if(month == 12){
        comps.month = month - 1;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
        
        comps.month = month;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
        
        comps.month = 1;
        comps.year = year + 1;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
    }
    else{
        
        comps.month = month - 1;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
        
        comps.month = month;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHOUTYEAR];
        
        comps.month = month + 1;
        comps.year = year;
        [JITOut cOneMonthOut:comps isWithYear:WITHOUTYEAR];
    }
}

+ (void)gYearOut:(JITDateComponents *)comps
{
    if(comps.year == 1725)
        fprintf(stdout, "\x1b[31mThis year could be inaccurate!\nPlease refer to: \x1b[4mhttps://en.wikipedia.org/wiki/1725\x1b[24m\x1b[30m");
    comps.month = 2;
    [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
    
    comps.month = 5;
    [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHOUTHEADER];
    
    comps.month = 8;
    [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHOUTHEADER];
    
    comps.month = 11;
    [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHOUTHEADER];
    
}

+ (void)cYearOut:(JITDateComponents *)comps
{
    if(comps.year == 1725)
        fprintf(stdout, "\x1b[31mThis year could be inaccurate!\nPlease refer to: \x1b[4mhttps://en.wikipedia.org/wiki/1725\x1b[24m\x1b[30m");
    
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    
    NSString *outS;
    comps.month = 2;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    
    NSInteger width = [JITInteger maxWidthOfString:outS];
    
    NSArray *cYear = @[@"",
                       @"甲子鼠年", @"乙丑牛年", @"丙寅虎年", @"丁卯兔年", @"戊辰龙年", @"己巳蛇年", @"庚午马年", @"辛未羊年", @"壬申猴年", @"癸酉鸡年", @"甲戌狗年", @"乙亥猪年",
                       @"丙子鼠年", @"丁丑牛年", @"戊寅虎年", @"己卯兔年", @"庚辰龙年", @"辛巳蛇年", @"壬午马年", @"癸未羊年", @"甲申猴年", @"乙酉鸡年", @"丙戌狗年", @"丁亥猪年",
                       @"戊子鼠年", @"己丑牛年", @"庚寅虎年", @"辛卯兔年", @"壬辰龙年", @"癸巳蛇年", @"甲午马年", @"乙未羊年", @"丙申猴年", @"丁酉鸡年", @"戊戌狗年", @"己亥猪年",
                       @"庚子鼠年", @"辛丑牛年", @"壬寅虎年", @"癸卯兔年", @"甲辰龙年", @"乙巳蛇年", @"丙午马年", @"丁未羊年", @"戊申猴年", @"己酉鸡年", @"庚戌狗年", @"辛亥猪年",
                       @"壬子鼠年", @"癸丑牛年", @"甲寅虎年", @"乙卯兔年", @"丙辰龙年", @"丁巳蛇年", @"戊午马年", @"己未羊年", @"庚申猴年", @"辛酉鸡年", @"壬戌狗年", @"癸亥猪年"];
    
    
    JITDateComponents *temp = [comps convertToChinese];

    NSString *header = [[NSString alloc] initWithFormat:@"%ld %@", comps.year, cYear[temp.year]];
    header = [JITString centerString:header withWidth:width];
    
    fprintf(stdout, "\n%s\n%s", [header UTF8String], [outS UTF8String]);
    
    outArray = nil;
    
    outArray = [[NSMutableArray alloc] init];
    comps.month = 4;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    fprintf(stdout, "\n%s", [outS UTF8String]);
    outArray = nil;
    
    outArray = [[NSMutableArray alloc] init];
    comps.month = 6;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    fprintf(stdout, "\n%s", [outS UTF8String]);
    outArray = nil;
    
    outArray = [[NSMutableArray alloc] init];
    comps.month = 8;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    fprintf(stdout, "\n%s", [outS UTF8String]);
    outArray = nil;
    
    outArray = [[NSMutableArray alloc] init];
    comps.month = 10;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    fprintf(stdout, "\n%s", [outS UTF8String]);
    outArray = nil;
    
    outArray = [[NSMutableArray alloc] init];
    comps.month = 12;
    [JITArray cAdjacentMonthArray:outArray inComps:comps isWithYear:WITHOUTYEAR];
    outS = [JITString formStringFromArray:outArray];
    fprintf(stdout, "\n%s", [outS UTF8String]);
    
}
@end
