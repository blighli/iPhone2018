//
//  Macros.h
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/27.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//** DEBUG LOG *********************************************************************************
// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%zd行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
// 销毁打印
#define CZDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

//** 屏幕尺寸相关 *********************************************************************************
#define SCREEN_WIDTH [[ UIScreen mainScreen ] bounds].size.width
#define SCREEN_HEIGHT [[ UIScreen mainScreen ] bounds].size.height
#define IPHONE_5_SCREEN_WIDTH      320
#define IPHONE_6_SCREEN_WIDTH      375
#define IPHONE_P_SCREEN_WIDTH      414
#define IPHONE_4_SCREEN_HEIGHT     480  //640x960
#define IPHONE_5_SCREEN_HEIGHT     568  //640x1136
#define IPHONE_6_SCREEN_HEIGHT     667  //750x1334
#define IPHONE_P_SCREEN_HEIGHT     736  //1242x2208
#define HEIGHT_45_MIN_SCALE(h)     floor(0.85332*h)
#define HEIGHT_6_MED_SCALE(h)      floor(1*h)
#define HEIGHT_6P_MAX_SCALE(h)     floor(1.104*h)
#define WIDTH_4_MAX_SCALE(h)       floor(0.71964018*h)
#define WIDTH_5_MAX_SCALE(h)       floor(0.85157421*h)
#define WIDTH_6_MAX_SCALE(h)       floor(1*h)
#define WIDTH_6P_MAX_SCALE(h)      floor(1.10244828*h)

//** 系统相关 *********************************************************************************
//一些缩写
#define kApplication                [UIApplication sharedApplication]
#define kKeyWindow                  [[UIApplication sharedApplication] keyWindow]
#define kAppDelegate                ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kWeakSelf(type)              __weak typeof(type)weak##type = type;
#define kStrongSelf(type)            __strong typeof(type)type = weak##type;
#define WEAK  @weakify(self);
#define STRONG  @strongify(self);

///系统版本
#define IOS_VERSION                 ［[UIDevice currentDevice] systemVersion] floatValue]
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define IS_IPHONE                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD                     (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//** 属性相关 *********************************************************************************
#define CZColor(r, g, b, a)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define CZColorHexString(str)      [UIColor colorWithHexString:@#str]
#define CZFont(font)               [UIFont systemFontOfSize:(font)]
#define CZBFont(font)              [UIFont boldSystemFontOfSize:(font)]

//** 沙盒路径 ***********************************************************************************
#define CZ_PATH_OF_APP_HOME          NSHomeDirectory()
#define CZ_PATH_OF_APP_TEMP          NSTemporaryDirectory()
#define CZ_PATH_OF_APP_DOCUMENT      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

///由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
///由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)
///字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
///数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
///字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
///是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
///APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
///系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
///获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
///获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)



//=====================单例==================
// @interface
#define singleton_interface(className) \
+ (className *)shared;


// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif /* Macros_h */
