//
//  CZHandlerEnterBackground.m
//  91VPN
//
//  Created by weichengzong on 2017/9/20.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZHandlerEnterBackground.h"

@implementation CZHandlerEnterBackground

+ (void)addObserverUsingBlock:(YTHandlerEnterBackgroundBlock)block {
    __block CFAbsoluteTime enterBackgroundTime;
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (![note.object isKindOfClass:[UIApplication class]]) {
            enterBackgroundTime = CFAbsoluteTimeGetCurrent();
        }
    }];
    __block CFAbsoluteTime enterForegroundTime;
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (![note.object isKindOfClass:[UIApplication class]]) {
            enterForegroundTime = CFAbsoluteTimeGetCurrent();
            CFAbsoluteTime timeInterval = enterForegroundTime-enterBackgroundTime;
            block? block(note, timeInterval): nil;
        }
    }];
}

+ (void)removeNotificationObserver:(id)observer {
    if (!observer) {
        return;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:observer name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:observer name:UIApplicationWillEnterForegroundNotification object:nil];
}


@end
