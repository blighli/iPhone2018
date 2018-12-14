//
//  AppUserDefaults.m
//  Nitrogen-mac
//
//  Created by czy on 12/11/2018.
//  Copyright © 2018 czy. All rights reserved.
//

#import "AppUserDefaults.h"

@def_app_package(AppUserDefaults, [AppUserDefaults sharedInstance], defaults);

@implementation AppUserDefaults

@def_singleton(AppUserDefaults);

- (void)setClassScore:(NSString *)classScore
{
    [[NSUserDefaults standardUserDefaults] setObject:classScore forKey:@"classScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)classScore
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"classScore"];
}


- (void)setJiejiScore:(NSString *)jiejiScore
{
    [[NSUserDefaults standardUserDefaults] setObject:jiejiScore forKey:@"jiejiScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)jiejiScore
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"jiejiScore"];
}

@end
