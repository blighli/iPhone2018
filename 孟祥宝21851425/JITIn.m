//
//  JITIn.m
//  JITCalendar
//
//  Created by JuicyITer on 17/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITIn.h"

@implementation JITIn

+ (void)handleOption:(NSMutableArray *)argList
{
    NSString *option = argList[0];
    if([option characterAtIndex:0] == '-'){
        // possibly an option
        if([option isEqualToString:@"-3"]){
            
            if([argList count] > 1 && [argList[1] isEqualToString:@"-L"]){
                if([argList count] > 2 && [argList[2] isEqualToString:@"-m"])
                    [JITIn handleParameters:argList withOption:1];  // 1 -3-L-m
                else
                    [JITIn handleParameters:argList withOption:2];    // 2 -3-L
            }
            else{
                if([argList count] > 2 && [argList[2] isEqualToString:@"-m"])
                    [JITIn handleParameters:argList withOption:3];    // 3 -3-m
                else
                    [JITIn handleParameters:argList withOption:4];      // 4 -3
            }
        }
        else if([option isEqualToString:@"-L"]){
            
            if([argList count] > 1 && [argList[1] isEqualToString:@"-3"]){
                if([argList count] > 2 && [argList[2] isEqualToString:@"-m"])
                    [JITIn handleParameters:argList withOption:5];  // 5 -3-L-m
                else
                    [JITIn handleParameters:argList withOption:6];    // 6 -3-L
            }
            else{
                if([argList count] > 1 && [argList[1] isEqualToString:@"-m"])
                    [JITIn handleParameters:argList withOption:7];    // 7 -L-m
                else
                    [JITIn handleParameters:argList withOption:8];      // 8 -L
            }
            
            
        }
        else if([option isEqualToString:@"-m"])
            [JITIn handleParameters:argList withOption:9];              // 9 -m
        else if([option isEqualToString:@"-h"])
            system("man $PWD/MAN");
        else
            [JITError illegalOption:option];
    }
    else
        [JITIn handleParameters:argList withOption:0];                    // 0
}

+ (void)handleParameters:(NSMutableArray *)argList
              withOption:(NSInteger)op
{
    JITDateComponents *comps = [JITDateComponents alloc];
    switch (op) {
        case 1:
        case 5:
            // lunar adjacent months. op: -3-L-m
            // arguments should be exact
            if([argList count] > 6)
                [JITError illegalUsage];
            else if([argList count] == 5){
                NSInteger month = [JITInteger numberFromString:argList[3]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[3]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[4]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[4]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut cAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else if([argList count] == 4){
                NSInteger month = [JITInteger numberFromString:argList[3]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[3]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
            }
            else
                [JITError requireArgument];
        
            break;
        case 2:
        case 6:
            // lunar adjacent months. op: -3-L
            
            if([argList count] > 5)
                [JITError illegalUsage];
            else if([argList count] == 4){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[3]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[3]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut cAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
                [JITOut cAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else{
                JITDateComponents *temp = [JITDateComponents newDateWithYear:1970];
                [JITOut cAdjacentMonthsOut:[temp today] isWithHeader:WITHHEADER];
            }
                
            
            break;
        case 3:
            // gregorian adjacent months. op: -3-m
            // arguments should be exact
            if([argList count] > 5)
                [JITError illegalUsage];
            else if([argList count] == 4){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[3]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[3]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
                [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else
                [JITError requireArgument];
            
            break;
        case 4:
            // gregorian adjacent months. op: -3
            if([argList count] > 4)
                [JITError illegalUsage];
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[1]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[1]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[2]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else if([argList count] == 2){
                NSInteger month = [JITInteger numberFromString:argList[1]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[1]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
                [JITOut gAdjacentMonthsOut:comps isWithHeader:WITHHEADER];
            }
            else{
                JITDateComponents *temp = [JITDateComponents newDateWithYear:1970];
                [JITOut gAdjacentMonthsOut:[temp today] isWithHeader:WITHHEADER];
            }
            
            break;
        
        
        case 7:
            // lunar month. op: -L-m
            // arguments should be exact
            if([argList count] > 5)
                [JITError illegalUsage];
            else if([argList count] == 4){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[3]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[3]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[2]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
                [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else
                [JITError requireArgument];
            
            break;
        case 8:
            // lunar month or year. op: -L
           
            if([argList count] > 4)
                [JITError illegalUsage];
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[1]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[1]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[2]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut cOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else if([argList count] == 2){
                NSInteger year = [JITInteger numberFromString:argList[1]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[1]];
                    break;
                }
                comps = [JITDateComponents newDateWithYear:year];
                [JITOut cYearOut:comps];
            }
            else{
                JITDateComponents *temp = [JITDateComponents newDateWithYear:1970];
                [JITOut cOneMonthOut:[temp today] isWithYear:WITHYEAR];
            }
            
            break;
        case 9:
            // gregorian month. op: -m
            if([argList count] > 4)
                [JITError illegalUsage];
            else if([argList count] == 3){
                NSInteger month = [JITInteger numberFromString:argList[1]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[1]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[2]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[2]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut gOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else if([argList count] == 2){
                NSInteger month = [JITInteger numberFromString:argList[1]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[1]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month];
                [JITOut gOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else
                [JITError requireArgument];
            
            break;
        case 0:
            // gregorian month or year. op:
            
            if([argList count] > 3)
                [JITError illegalUsage];
            else if([argList count] == 2){
                NSInteger month = [JITInteger numberFromString:argList[0]];
                if(month < 1 || month > 12){
                    [JITError illegalMonth:argList[0]];
                    break;
                }
                NSInteger year = [JITInteger numberFromString:argList[1]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[1]];
                    break;
                }
                comps = [JITDateComponents newDateWithMonth:month year:year];
                [JITOut gOneMonthOut:comps isWithYear:WITHYEAR];
            }
            else if([argList count] == 1){
                NSInteger year = [JITInteger numberFromString:argList[0]];
                if(year < 1 || year > 9999){
                    [JITError illegalYear:argList[0]];
                    break;
                }
                comps = [JITDateComponents newDateWithYear:year];
                [JITOut gYearOut:comps];
            }
            else{
                JITDateComponents *temp = [JITDateComponents newDateWithYear:1970];
                [JITOut gOneMonthOut:[temp today] isWithYear:WITHYEAR];
            }
            
            break;
        default:
            break;
    }
}

@end
