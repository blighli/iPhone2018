//
//  HeadDefine.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//


#define DEFAULT_GRAY_COLOR_SEZHI @"#5f5f5f"
#define DEFAULT_RED_COLOR_SEZHI  @"#e62e2d"
#define DEFAULT_BLACK_COLOR_SEZHI @"#000000"

#define GRAY    [UIColor grayColor]
#define tabbarCount (4)
//#define TABBARHEIGHT (48)
#define tabbarTag (99)
#define tabbarButtonTag (100)

#define StateBar 1

//#define navigationHeight (44)
#define backButtonTag (110)
#define menuButtonTag (111)
#define rightButtonTag (112)
#define NSNOTIFATIONCHAT
/*
 0 no stateBar
 1 has stateBar
 */
#define deviceHasStateBar 1

/*
 0 left or right
 1 up or down
 */
#define deviceOrientation 1

//16进制颜色值
#define ColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SetColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define SetAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 设置字体
#define SetFont(fontName,font)    [UIFont fontWithName:(fontName) size:(font)]



#define IOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])


#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_7_1
#define IOS7 ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1))
#else
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#endif


#ifdef DEBUG
    #   define MKLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #   define MKLog(...)
#endif



#if __has_feature(objc_arc)
    #define SAFE_ARC_PROP_RETAIN strong
    #define SAFE_ARC_RETAIN(x) (x)
    #define SAFE_ARC_RELEASE(x)
    #define SAFE_ARC_AUTORELEASE(x) (x)
    #define SAFE_ARC_BLOCK_COPY(x) (x)
    #define SAFE_ARC_BLOCK_RELEASE(x)
    #define SAFE_ARC_SUPER_DEALLOC()
    #define SAFE_ARC_AUTORELEASE_POOL_START() @autoreleasepool {
    #define SAFE_ARC_AUTORELEASE_POOL_END() }
#else
    #define SAFE_ARC_PROP_RETAIN retain
    #define SAFE_ARC_RETAIN(x) ([(x) retain])
    #define SAFE_ARC_RELEASE(x) ([(x) release])
    #define SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
    #define SAFE_ARC_BLOCK_COPY(x) (Block_copy(x))
    #define SAFE_ARC_BLOCK_RELEASE(x) (Block_release(x))
    #define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
    #define SAFE_ARC_AUTORELEASE_POOL_START() NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    #define SAFE_ARC_AUTORELEASE_POOL_END() [pool release];
#endif





#define Window [[UIApplication sharedApplication] keyWindow]
#define kLastWindow [UIApplication sharedApplication].keyWindow

#define KEY_ENCRYPT

#define IS_IPHONE4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE6P ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define IS_LARGESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )








//#define image_doc_Url @"http://10.30.11.184:8080/YCYL/"
//#define SERVER_MAIN_ADDRESS @"http://10.30.11.184:8080/YCYL/app/"



//#define testAddress @"http://180.76.153.68/" //测试地址
////#define testAddress @"http://dsp.adclick.com.cn/" //正式上线地址
//#define productAddressName @"https://host:port/v1/"//域名
//#define salt @"%7F$S0V34I-9R*DCGu|BTv)=zkplrtKqjN:h_P]Y@gMQes!cZ<Owb>aJ[E}nd#6(52f?UL1\{&8WAHoy/X+imx"
//
//
//#define kConstString    @"60670279"
//#define fConstString    @"97207606"
//
//#define gapsize 45
//
//
//#define LOADIMAGE(fileName,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:ext]]
//
//#import <Foundation/Foundation.h>
//#import "Util.h"
////#import "UIImageView+WebCache.h"
//#import "UIView+AFAcitivityIndicator.h"
//#import "UIView+MessageBorder.h"
//#import "MKButton.h"
//#import "MKAlertView.h"
//#import "UIView+Border.h"
//#import "MKTextField.h"
//#import "MJRefresh.h"
//#import "UITableView+Placeholder.h"
//
//#import "HeadDefine.h"
//#import "AFNetInterFaceManager.h"
//#import "SliderViewController.h"
//#import "MyUserInfo.h"
//#import "UIImageView+WebCache.h"
//#import "ReactiveCocoa-umbrella.h"
//#import "ReactiveCocoa.h"
//#import "UIParameter.h"
//#import "NinaPagerView.h"



@interface HeadDefine : NSObject


@end
