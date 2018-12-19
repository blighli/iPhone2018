//
//  AppData.m
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import "AppData.h"

@implementation AppData

+(id) getInstance
{
    static AppData *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"]];
        instance.clientId = [dictionary objectForKey:@"clientId"];
        instance.authority = [dictionary objectForKey:@"authority"];
        instance.resourceId = [dictionary objectForKey:@"resourceString"];
        instance.redirectUriString = [dictionary objectForKey:@"redirectUri"];
        instance.graphApiUrlString = [dictionary objectForKey:@"graphAPI"];
        instance.apiversion = [dictionary objectForKey:@"api-version"];
        instance.tenant = [dictionary objectForKey:@"tenant"];
        instance.secret = [dictionary objectForKey:@"secret"];
        
    });
    
    return instance;
}

@end
