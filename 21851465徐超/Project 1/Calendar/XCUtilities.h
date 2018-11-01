//
//  XCUtilities.h
//  Calendar
//
//  Created by 徐超 on 2018/10/15.
//  Copyright © 2018 徐超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  通用工具类.
 */
@interface XCUtilities : NSObject

/**
 *  判断一个NSString对象是否是一个整数.
 *
 *  @param str 受查NSString对象.
 *  @retuan 是一个整数返回YES；否则，返回NO.
 */
+ (BOOL)isPureInt:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
