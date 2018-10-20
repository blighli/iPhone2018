//
//  JITError.m
//  JITCalendar
//
//  Created by JuicyITer on 17/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITError.h"

@implementation JITError

+ (void)illegalUsage
{
    NSString *usage =
    @"Usage: jcal [general option] [[month] year]\n\
       jcal [general option] [[-m month] year]\n\
General options:  [-3L]\n\
For more help: \'jcal -h\'";
    
    fprintf(stdout, "%s\n", [usage UTF8String]);
}

+ (void)illegalYear:(NSString *)year
{
    NSString *error = [[NSString alloc] initWithFormat:@"jcal: year '%@' not in range 1..9999", year];
    fprintf(stdout, "%s\n", [error UTF8String]);
    [JITError illegalUsage];
}

+ (void)illegalMonth:(NSString *)month
{
    NSString *error = [[NSString alloc] initWithFormat:@"jcal: month '%@' not in range 1..12", month];
    fprintf(stdout, "%s\n", [error UTF8String]);
    [JITError illegalUsage];
}

+ (void)requireArgument
{
    NSString *error = @"jcal: option requires an argument -- m";
    fprintf(stdout, "%s\n", [error UTF8String]);
    [JITError illegalUsage];
}

+ (void)illegalOption:(NSString *)op
{
    NSString *option = [op substringFromIndex:1];
    NSString *error = [[NSString alloc] initWithFormat:@"jcal: illegal option -- %@", option];
    fprintf(stdout, "%s\n", [error UTF8String]);
    [JITError illegalUsage];
}



@end
