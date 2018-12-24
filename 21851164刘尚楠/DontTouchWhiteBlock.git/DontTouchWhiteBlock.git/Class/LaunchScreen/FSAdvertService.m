//
//  FSAdvertService.m
//  Nitrogen
//
//  Created by czy on 2018/12/2.
//  Copyright © 2018年 czy. All rights reserved.
//

#import "FSAdvertService.h"

@def_app_package(FSAdvertService, [FSAdvertService sharedInstance], advert);

@implementation FSAdvertService

@def_singleton(FSAdvertService);

- (FSLaunchScreenView *)setUpLaunchScreenView
{
    FSLaunchScreenView *launchView = [FSLaunchScreenView new];
    return launchView;
}

@end
