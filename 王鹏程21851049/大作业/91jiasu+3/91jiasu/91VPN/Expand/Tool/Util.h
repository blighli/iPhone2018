//
//  Util.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Util : NSObject

//监测系统版本
+ (NSInteger)OSVersion;
//md5加密
+ (NSString *)md5:(NSString *)str;
///录音保存路径
+ (NSString *)recordPath;
//AES加密
+ (NSString *)AESEncryptTime:(UInt64)times uid:(NSString *)uid url:(NSString *)url;
//创建UILabel
+ (UILabel *)labRectMakeWithTitleAndFontSize:(CGRect)rect title:(NSString *)title fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

//创建自定义Button
+ (UIButton *)btnRectMakeWithImageName:(CGRect)rect normalName:(NSString *)normalName highlightName:(NSString *)highlightName;

//创建自定义Button
+ (UIButton *)btnRectMakeWithBackImageName:(CGRect)rect title:(NSString *)title normalName:(NSString *)normalName;


//创建UIImageView
+ (UIImageView *)imageViewRectWithImageName:(CGRect)rect imageName:(NSString *)imageName;

//创建UIView
+ (UIView *)viewWithRect:(CGRect)rect;

//创建UITextField
+ (UITextField *)textFieldRectWithPlaceText:(CGRect)rect  placeText:(NSString *)placeText;

+ (UIImage*) getImageFromProject : (NSString*) path;

//navigation添加主标题
+ (UIView *)navTitleViewWithTitle:(NSString *)title;

//添加阴影
+ (void)shadowWithView:(UIView *)sview shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity;

//添加阴影
+ (void)shadowWithView:(UIView *)tview shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;

//添加阴影
+ (void)roundCornerWithView:(UIView *)rview radius:(CGFloat)radius lineColor:(UIColor *)rcolor lineWidth:(CGFloat)rwidth;

//裁剪圆角
+ (void)roundcornerRadiusView:(UIView *)rview radius:(CGFloat)radius;

+ (NSString*)stringFromHourAddMinutes:(NSString *)str;
+ (NSString*)stringFromDateString11:(NSString *)str;
+ (NSString*)stringFromMonthAddDay:(NSString *)str;
+ (NSString *)nowtime:(NSString *)nowtime xiaoshi:(int)data;
+ (NSString *)nowtime:(NSString *)nowtime tian:(int)data;
+ (NSString *)numbertime:(NSString *)nowtime tian:(int)data;
+(NSString *)getNowTimeTimeType;
+ (NSString *)BeforeACertainPeriodOfTime:(NSString *)startTime endTime:(NSString *)endTime;
//获取当前时间
+(NSString *)getNowTimeTimestamp;
//格式化时间
+ (NSString*)stringFromDateString:(NSString *)str;
//时间戳转换日期
+ (NSString *)getStringToTimeString:(NSString *)string;
//格式化时间
+ (NSString*)stringFromDateString2:(NSString *)str;
+ (NSString*)stringFromDateString3:(NSString *)str;
//格式化时间
+ (NSString *)stringFromDateFormat:(NSString *)dateStr;

//将时间类型转为固定的字符类型
+ (NSString*)stringFromYMDDate:(NSDate *)date;
+ (NSString*)stringFromYMDDate2:(NSDate *)date;
//将时间类型转为固定的字符类型
+ (NSString*)stringFromDate:(NSDate *)date;

//将字符类型转为固定的时间类型
+ (NSDate *)dateFromString:(NSString *)str;

//将时间类型转为固定的字符类型
+ (NSString *)stringFromCurrentDate:(NSDate *)date;

//根据秒数计算累计时间
+ (NSString *)getFromatterAfterDate:(float)intervalDate;

//判断是否工作时间
+ (BOOL)isWorkTime;

//将数组进行排序
+ (NSArray *)getSortAfterArray:(NSMutableArray *)dataArray sortName:(NSString *)sortName isAsc:(BOOL)isAsc;

//将数组进行排序
+ (NSMutableArray *)getSortAfterNewArray:(NSMutableArray *)dataArray sortName:(NSString *)sortName isAsc:(BOOL)isAsc;

//替换空格或隔段。
+ (NSString *)getReplaceAfterString:(NSString *)str;


//截屏幕图片
+ (UIImage *)getScreenshotImageView:(UIView *)shotView;

//图片裁剪
+ (UIImage *)croppedImage:(UIImage *)image;

//是否手机号码
+ (BOOL)isPhoneNumber:(NSString *)mobile;
/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 布尔值
 */
+ (BOOL)isValidateEmail:(NSString *)email;

//根据key值找到数组里面相应地数据
+ (NSArray *)getSearchForArrayAtKey:(NSArray *)sourceArray  key:(NSString *)key;

//设置字体大小
+ (void)setDefaultFont:(id)sender size:(float)size text:(BOOL)text;


//移除键盘事件
+ (void)resignKeyBoardInView:(UIView *)view;
//文字提示
+ (void)setTextMessage:(NSString *)text;
//颜色值的转换
+ (UIColor *) colorWithHexString: (NSString *) hexString;


#pragma mark AppDelegate逻辑跳转代理方法
+ (void) changeViewControllerWithTabbarIndex : (int) _tabbarIndex;

+ (CGFloat)calculateMeaasgeHeightWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font;
+ (CGFloat)calculateMeaasgeWidthWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font ;

+ (CGFloat)getHeight:(float)height;

+ (CGFloat)getWidth:(float)width;

// 请求时数字签名
+ (NSString*)baseSignString:(NSString *)action withSubmitTime:(NSString*)submitTime;

// 返回时数字签名
+ (NSString*)basebackSignString:(NSString *)action withbackSubmitTime:(NSString*)submitTime;
//string 数据安全
+ (NSString *)StringSecurity:(NSString *)string;
@end
