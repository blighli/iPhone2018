//
//  CZHandlerEnterBackground.h
//  91VPN
//
//  Created by weichengzong on 2017/9/20.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 进入后台block typedef */
typedef void(^YTHandlerEnterBackgroundBlock)(NSNotification * _Nonnull note, NSTimeInterval stayBackgroundTime);


@interface CZHandlerEnterBackground : NSObject

/** 添加观察者并处理后台 */
+ (void)addObserverUsingBlock:(nullable YTHandlerEnterBackgroundBlock)block;
/** 移除后台观察者 */
+ (void)removeNotificationObserver:(nullable id)observer;


@end
