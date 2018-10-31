//
//  JITString.m
//  JITCalendar
//
//  Created by JuicyITer on 15/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITString.h"

@implementation JITString

+ (NSString *)gStringFromArray:(NSMutableArray *)arr
                      inComps:(JITDateComponents *)comps
{
    NSInteger maxLength = [JITInteger maxLengthInStrings:arr];
    JITDateComponents *temp = [comps convertToChinese];
    NSString *header = [[NSString alloc] initWithFormat:@"%@ %ld", comps.calendar.monthSymbols[comps.month - 1],\
                        comps.year];
    temp = nil;
    
    NSString *outString = [[NSString alloc] init];
    for(NSInteger i = 0; i < [arr count]; i++){
        NSInteger length = [JITInteger stringLength:arr[i]];
        
        for(int i = 0; i < maxLength - length; i++){
            outString = [outString stringByAppendingString:@" "];
        }
        
        NSInteger dayNum = [JITInteger numberFromString:arr[i]];
        
        NSString *dayString = [JITString beautifyString:arr[i]
                                                withDay:dayNum
                                           inComps:comps
                                             withStyle:GREGORIAN];
        
        outString = [outString stringByAppendingString:dayString];
        
        if(((i + 1) % [comps.calendar.weekdaySymbols count] == 0) | (i == [arr count] - 1))
            outString = [outString stringByAppendingString:@"\n"];
        else
            outString = [outString stringByAppendingString:@" "];
        
    }
    NSInteger maxWidth = 7 * (maxLength + 1);
    
    header = [JITString centerString:header withWidth:maxWidth];
    header = [header stringByAppendingString:outString];
    return header;
}

+ (NSString *)cStringFromArray:(NSMutableArray *)arr
                       inComps:(JITDateComponents *)comps
{
    NSString *outString = [[NSString alloc] init];
    NSInteger maxLength = [JITInteger maxLengthInStrings:arr];
    for(NSInteger i = 1; i < [arr count]; i++){
        NSInteger length = [JITInteger stringLength:arr[i]];
        
        for(int i = 0; i < maxLength - length; i++){
            outString = [outString stringByAppendingString:@" "];
        }
        
        NSInteger dayNum = [JITInteger numberFromString:arr[i]];
        
        NSString *dayString = [JITString beautifyString:arr[i]
                                                withDay:dayNum
                                           inComps:comps
                                             withStyle:CHINESE];
        
        outString = [outString stringByAppendingString:dayString];
        
        if((i % [comps.calendar.weekdaySymbols count] == 0) | (i == [arr count] - 1))
            outString = [outString stringByAppendingString:@"\n"];
        else
            outString = [outString stringByAppendingString:@" "];
        
    }
    NSInteger maxWidth = 7 * (maxLength + 1);
    NSString *header = arr[0];
    header = [JITString centerString:header withWidth:maxWidth];
    header = [header stringByAppendingString:outString];
    return header;
}

+ (NSString *)beautifyString:(NSString *)str
                     withDay:(NSInteger)day
                     inComps:(JITDateComponents *)comps
                   withStyle:(NSInteger)style
{
    
    // Today's info
    JITDateComponents *today = [comps today];
    NSString *outString = [NSString string];
    if(day < 1)
        return str;
    if(style){
        // highlight
        if(day == today.day && comps.month == today.month && comps.year == today.year){
            // emmm this is today, tag it
            outString = [outString stringByAppendingFormat:@"\x1b[31m%@\x1b[39m", str];
        }
        else
            outString = [outString stringByAppendingString:str];
    }
    else{
        // underline
        if(day > 0 && day < 10){
            outString = [JITString insertString:str withString:@"\x1b[4m" atIndex:2];
            outString = [JITString insertString:outString withString:@"\x1b[24m" atIndex:[outString length] - 1];
        }
        else if(day > 0){
            outString = [JITString insertString:str withString:@"\x1b[4m" atIndex:3];
            outString = [JITString insertString:outString withString:@"\x1b[24m" atIndex:[outString length] - 1];
        }
        
        // Then highlight
        outString = [JITString beautifyString:outString
                                       withDay:day
                                      inComps:comps
                                    withStyle:GREGORIAN];
    }
    return outString;
}
+ (NSString *)insertString:(NSString *)origin
                withString:(NSString *)str
                   atIndex:(NSInteger)index
{
    
    NSString *start = [origin substringToIndex:index];
    
    NSString *end = [origin substringFromIndex:index];
    
    NSString *string = [NSString string];
    string = [string stringByAppendingString:start];
    string = [string stringByAppendingString:str];
    string = [string stringByAppendingString:end];
    
    return string;
}


+ (NSString *)centerString:(NSString *)str
                 withWidth:(NSInteger)width
{
    NSString *outS = [NSString string];
    for(NSInteger i = 0; i < (width - [JITInteger stringLength:str]) / 2; i++){
        outS = [outS stringByAppendingString:@" "];
    }
    outS = [outS stringByAppendingString:str];
    for(NSInteger i = 0; i < (width - [JITInteger stringLength:str]) / 2; i++){
        outS = [outS stringByAppendingString:@" "];
    }
    
    return outS;
}

+ (NSString *)formStringFromArray:(NSMutableArray *)arr
{
    
    NSString *outS = [NSString string];
    NSMutableArray *stringArr = [[NSMutableArray alloc] init];
    NSString *firstLine = [NSString string];
    
    NSString *secondLine = [NSString string];
    [stringArr addObject:secondLine];
    NSString *thirdLine = [NSString string];
    [stringArr addObject:thirdLine];
    NSString *forthLine = [NSString string];
    [stringArr addObject:forthLine];
    NSString *fifthLine = [NSString string];
    [stringArr addObject:fifthLine];
    NSString *sixthLine = [NSString string];
    [stringArr addObject:sixthLine];
    NSString *seventhLine = [NSString string];
    [stringArr addObject:seventhLine];
    NSString *eighthLine = [NSString string];
    [stringArr addObject:eighthLine];
    
    for(NSInteger i = 0; i < [arr count]; i++){
        if(i == 0 || i == COUNT || i == 2*COUNT){
            // header
            firstLine = [firstLine stringByAppendingString:arr[i]];
            if( i + COUNT >= [arr count])
                firstLine = [firstLine stringByAppendingString:@"\n"];
            else
                firstLine = [firstLine stringByAppendingString:@"    "];
        }
        else{
            NSInteger line = [JITInteger getLine:i];
            
            stringArr[line] = [stringArr[line] stringByAppendingString:arr[i]];
            if([JITInteger isLastInWeek:i]){
                if(i + COUNT > [arr count]){
                    // last in the line
                    stringArr[line] = [stringArr[line] stringByAppendingString:@"\n"];
                }
                else
                    stringArr[line] = [stringArr[line] stringByAppendingString:@" | "];
            }
            
        }
    }
    
    outS = [outS stringByAppendingString:firstLine];
    for(NSString *item in stringArr)
        outS = [outS stringByAppendingString:item];
    
    return outS;
}
@end
