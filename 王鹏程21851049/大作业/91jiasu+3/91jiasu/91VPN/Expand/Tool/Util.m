//
//  Util.m
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import "Util.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import <MapKit/MKFoundation.h>
//static const NSString *MKTitleButtonKey  =  @"MKTitleButtonKey";

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


@implementation Util


+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (UIImage *)getImageFromProject:(NSString *)path
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
}
+ (UILabel *)labRectMakeWithTitleAndFontSize:(CGRect)rect title:(NSString *)title fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor{
    
    UILabel * lable = [[UILabel alloc] initWithFrame:rect];
    lable.font = [UIFont systemFontOfSize:fontSize];
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = fontColor;
    lable.text = title;
    
    return lable;
}


///录音保存路径
+ (NSString *)recordPath
{
    NSString *path;
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[documentPath objectAtIndex:0] stringByAppendingPathComponent:@"voidce.caf"];
    NSLog(@"path %@",path);
    return path;
    
}

+ (UIView *)navTitleViewWithTitle:(NSString *)title{
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    lable.font = [UIFont systemFontOfSize:23];
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.text = title;
    
    lable.layer.shadowOffset = CGSizeMake(0, -1);
    lable.layer.shadowRadius = 1;
    lable.layer.shadowColor = [UIColor blackColor].CGColor;
    lable.layer.shadowOpacity = 0.2;
    
    return lable;
}

+ (UIButton *)btnRectMakeWithImageName:(CGRect)rect normalName:(NSString *)normalName highlightName:(NSString *)highlightName {
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)btnRectMakeWithBackImageName:(CGRect)rect title:(NSString *)title normalName:(NSString *)normalName{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    return btn;
}


+ (UIImageView *)imageViewRectWithImageName:(CGRect)rect imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}


+ (UIView *)viewWithRect:(CGRect)rect{
    UIView *tbackView = [[UIView alloc] initWithFrame:rect];
    tbackView.backgroundColor = [UIColor whiteColor];
    tbackView.layer.borderColor = [UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:1.0f].CGColor;
    tbackView.layer.borderWidth = 0.5f;
    tbackView.layer.cornerRadius = 5.0f;
    tbackView.layer.masksToBounds = YES;
    return tbackView;
}


+ (UITextField *)textFieldRectWithPlaceText:(CGRect)rect  placeText:(NSString *)placeText {
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:15.0f];
    textField.textColor = [UIColor blackColor];
    textField.placeholder = placeText;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    
    return textField;
}


+ (void) changeViewControllerWithTabbarIndex : (int) _tabbarIndex
{
//    [(AppDelegate*)[[UIApplication sharedApplication] delegate] changeViewController:_tabbarIndex];
}





+ (void)shadowWithView:(UIView *)sview shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity{
    sview.layer.shadowColor = [UIColor blackColor].CGColor;
    sview.layer.shadowOffset = offset;
    sview.layer.shadowOpacity = opacity;
    sview.layer.shadowRadius = 2.0;
}


+ (void)shadowWithView:(UIView *)tview shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius{
    tview.layer.shadowOffset = offset;
    tview.layer.shadowRadius = radius;
    tview.layer.shadowColor = [UIColor blackColor].CGColor;
    tview.layer.shadowOpacity = opacity;
}

+ (void)roundCornerWithView:(UIView *)rview radius:(CGFloat)radius lineColor:(UIColor *)rcolor lineWidth:(CGFloat)rwidth{
    
    rview.layer.cornerRadius = radius;
    rview.layer.borderColor = rcolor.CGColor;
    rview.layer.borderWidth = rwidth;
    rview.layer.masksToBounds = YES;
}



+ (void)roundcornerRadiusView:(UIView *)rview radius:(CGFloat)radius{
    
    rview.layer.cornerRadius = radius;
    rview.layer.masksToBounds = YES;
}


+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *strDate = [formatter stringFromDate:datenow];
    
    return strDate;
}

+(NSString *)getNowTimeTimeType{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *strDate = [formatter stringFromDate:datenow];
    
    return strDate;
}



+ (NSString*)stringFromHourAddMinutes:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [dateFormat dateFromString:str];
    
    
    [dateFormat setDateFormat:@"HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [dateFormat stringFromDate:curDate];
    
    return resultDate;
}

+ (NSString*)stringFromMonthAddDay:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [dateFormat dateFromString:str];
    
    
    [dateFormat setDateFormat:@"MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [dateFormat stringFromDate:curDate];
    SAFE_ARC_RELEASE(dateFormat);
    
    return resultDate;
}


+ (NSString*)stringFromDateString11:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [dateFormat dateFromString:str];
    
    
    [dateFormat setDateFormat:@"HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [dateFormat stringFromDate:curDate];
    SAFE_ARC_RELEASE(dateFormat);
    
    return resultDate;
}

+ (NSString *)nowtime:(NSString *)nowtime tian:(int)data{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:nowtime];
//    NSLog(@"dateFromString = %@", date);
    //date to timestamp
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *time;
    [formatter setDateFormat:@"MM-dd"];
    
    NSTimeInterval endtime = currentTime - data*24*60*60-8*60*60;
    time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
    
    
    return time;
    
}


+ (NSString *)nowtime:(NSString *)nowtime xiaoshi:(int)data{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:nowtime];
    //date to timestamp
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *time;
    [formatter setDateFormat:@"HH:mm"];
        
    NSTimeInterval endtime = currentTime - data*60*60;
    time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
    
    
    return time;
    
}


+ (NSString *)numbertime:(NSString *)nowtime tian:(int)data{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:nowtime];
    //    NSLog(@"dateFromString = %@", date);
    //date to timestamp
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *time;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSTimeInterval endtime = currentTime - data*24*60*60-8*60*60;
    time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
    
    
    return time;
    
}







+ (NSString *)BeforeACertainPeriodOfTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    if (![startTime isKindOfClass:[NSString class]] || [startTime isEqualToString:@""]){
        return nil;
    }else{
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *time;
         if([endTime isEqualToString:@"7"]){
            NSTimeInterval endtime = currentTime - 7*24*60*60;
            time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
        }else if([endTime isEqualToString:@"30"]){
            NSTimeInterval endtime = currentTime - 30*24*60*60;
            time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
        }else if([endTime isEqualToString:@"1"]){
            [formatter setDateFormat:@"YYYY-MM-dd"];

            NSTimeInterval endtime = currentTime - 24*60*60;
            time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:endtime]];
        }
       
        
        return time;
    }
    
}

+ (NSString *)stringFromDateFormat:(NSString *)dateStr{
    
    float curInterval = [[NSDate date] timeIntervalSince1970];
    float timeInterval = [[Util dateFromString:dateStr] timeIntervalSince1970];
    float intervalDate = curInterval - timeInterval;
    NSString *resultDateStr = @"";
    if (intervalDate < 10) {
        return @"刚刚";
    }else if (intervalDate < 60){
        [NSString stringWithFormat:@"%d秒前",(int)intervalDate];
    }else if(intervalDate < 3600){
        resultDateStr = [NSString stringWithFormat:@"%.0f分钟前",intervalDate/60.0f];
    }else if(intervalDate < 3600*24){
        resultDateStr = [NSString stringWithFormat:@"%.0f小时前",intervalDate/3600.0f];
    }else if(intervalDate < 3600*24*7){
        resultDateStr = [NSString stringWithFormat:@"%.0f天前",intervalDate/3600/24.0f];
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM月dd"];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        NSDate *myDate = [self dateFromString:dateStr];
        resultDateStr = [formatter stringFromDate:myDate];
    }
    return resultDateStr;
}

+ (NSString*)stringFromDateString:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [formatter dateFromString:str];
    
    [formatter setDateFormat:@"yyyy年MM月dd日 HH点"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [formatter stringFromDate:curDate];
    SAFE_ARC_RELEASE(formatter);
    
    return resultDate;
}


+ (NSString*)stringFromDateString2:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [dateFormat dateFromString:str];
    

    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [dateFormat stringFromDate:curDate];
    SAFE_ARC_RELEASE(dateFormat);
    
    return resultDate;
}
+ (NSString*)stringFromDateString3:(NSString *)str{
    
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *curDate = [dateFormat dateFromString:str];
    
    
    [dateFormat setDateFormat:@"yyyyMMdd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *resultDate = [dateFormat stringFromDate:curDate];
    SAFE_ARC_RELEASE(dateFormat);
    
    return resultDate;
}



+ (NSString*)stringFromYMDDate:(NSDate *)date{
    if(![date isKindOfClass:[NSDate class]]) return nil;
    NSDateFormatter *formatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSString*)stringFromYMDDate2:(NSDate *)date{
    if(![date isKindOfClass:[NSDate class]]) return nil;
    NSDateFormatter *formatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}


+ (NSString*)stringFromDate:(NSDate *)date{
    if(![date isKindOfClass:[NSDate class]]) return nil;
    NSDateFormatter *formatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)str{
    if (![str isKindOfClass:[NSString class]] || [str isEqualToString:@""])
        return nil;
    NSDateFormatter *formatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter dateFromString:str];
}

+ (NSString *)stringFromCurrentDate:(NSDate *)date{
    if(![date isKindOfClass:[NSDate class]]) return nil;
    NSDateFormatter *dateFromatter = SAFE_ARC_AUTORELEASE([[NSDateFormatter alloc] init]);
    [dateFromatter setDateFormat:@"HH:mm"];
    [dateFromatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFromatter stringFromDate:date];
}

+ (NSString *)getFromatterAfterDate:(float)intervalDate{
    NSString *resultDate = @"";
    if (intervalDate < 60) {
        resultDate = [NSString stringWithFormat:@"%d秒",(int)intervalDate];
    }
    else if(intervalDate < 3600){
        resultDate = [NSString stringWithFormat:@"%.1f分钟",intervalDate/60.0f];
    }
    else{
        resultDate = [NSString stringWithFormat:@"%.1f小时",intervalDate/3600.0f];
    }
    return resultDate;
}

+ (NSString *)getStringToTimeString:(NSString *)string{
    
    if (![string isEqual:[NSNull null]]){
        NSString*str=string;//时间戳
        
        NSTimeInterval time=[str doubleValue]/1000;//因为时差问题要加8小时 == 28800 sec
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
        
        return currentDateStr;

    }else{
        return @"";
    }
    
    
    
}



+ (BOOL)isWorkTime{
    //  先定义一个遵循某个历法的日历对象
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    //  通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
    SAFE_ARC_RELEASE(greCalendar);
    if (dateComponents.hour>=9 && dateComponents.hour <= 18) {
        return YES;
    }
    
    return NO;
}


+ (NSArray *)getSortAfterArray:(NSMutableArray *)dataArray sortName:(NSString *)sortName isAsc:(BOOL)isAsc{
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:dataArray];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortName ascending:isAsc];//其中，sortName根据此属性进行排序 , YES 代表升序排列
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [sortArray sortUsingDescriptors:sortDescriptors];
    SAFE_ARC_RELEASE(sortDescriptor);
    SAFE_ARC_RELEASE(sortDescriptors);
    return sortArray;
}


+ (NSMutableArray *)getSortAfterNewArray:(NSMutableArray *)dataArray sortName:(NSString *)sortName isAsc:(BOOL)isAsc{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:dataArray];
    //正确有序排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortName ascending:isAsc comparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
        
    }];//其中，share_id为数组中的对象的属性，根据此属性进行排序 , YES 代表升序排列
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [tempArray sortUsingDescriptors:sortDescriptors];
    
    SAFE_ARC_RELEASE(sortDescriptor);
    SAFE_ARC_RELEASE(sortDescriptors);
    
    return tempArray;
}


+ (NSString *)getReplaceAfterString:(NSString *)str{
    NSString *afterStr = str;
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"\r'\r" withString:@"\r"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&qpos;" withString:@"'"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"—"];
    afterStr = [afterStr stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"…"];
    return afterStr;
}


+ (UIImage *)getScreenshotImageView:(UIView *)shotView{
    
    UIGraphicsBeginImageContextWithOptions(shotView.bounds.size, YES, 1.0f);
    [shotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return shotImage;
}



+ (UIImage *)croppedImage:(UIImage *)image

{
    if (image)
    {
        float min = MIN(image.size.width*2,image.size.height*2);
        CGRect rectMAX = CGRectMake((image.size.width*2-min)/2, (image.size.height*2-min)/2, min, min);
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rectMAX);
        
        UIGraphicsBeginImageContext(rectMAX.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, CGRectMake(0, 0, min, min), subImageRef);
        UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        return viewImage;
    }
    
    return nil;
    
}
+ (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isPhoneNumber:(NSString *)mobile
{
//    NSString * regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString * regex = @"1[34578]([0-9]){9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

+ (NSArray *)getSearchForArrayAtKey:(NSArray *)sourceArray  key:(NSString *)key{
    NSString *predicateText = key;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY DATA  CONTAINS[cd]%@",predicateText];
    NSArray *filteredArray = [sourceArray filteredArrayUsingPredicate:predicate];
    return filteredArray;
}


+ (void)setDefaultFont:(id)sender size:(float)size text:(BOOL)text{
    if (text==YES) {
        [sender setFont:[UIFont fontWithName:@"Arial-BoldMT" size:size]];
    }else{
        [sender setFont:[UIFont fontWithName:@"Helvetica" size:size]];
    }
}
+ (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}

+ (void)setTextMessage:(NSString *)text{
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MessageList" ofType:@"plist"]];
    NSString *key = [NSString stringWithFormat:@"%@",text] ;
    NSString *msg =[usersDic objectForKey:key];
    NSLog(@"错误信息 >>> %@",msg);
    if (msg.length>0) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window makeProgress:msg duration:2.0 postion:AFProgressCenterPosition];
    }else{
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window makeProgress:@"未知错误" duration:2.0 postion:AFProgressCenterPosition];
    }

}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}



NSMutableAttributedString *GetAttributedText(NSString *value) {//这里调整富文本的段落格式
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8.0];
//        [paragraphStyle setParagraphSpacing:11];  //调整段间距
//        [paragraphStyle setHeadIndent:75.0];//段落整体缩进
//        [paragraphStyle setFirstLineHeadIndent:.0];//首行缩进
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [value length])];
    return attributedString;
}
+ (CGFloat)calculateMeaasgeHeightWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (CGFloat)calculateMeaasgeWidthWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}




//+ (CGFloat)getHeight:(float)height{
//    float h;
//    if (IS_IPHONE5) {
//        h = HEIGHT_45_MIN_SCALE(height);
//    }else if (IS_IPHONE6){
//        h = height;
//    }else if (IS_IPHONE6P){
//        h = HEIGHT_6P_MAX_SCALE(height);
//    }
//    return h;
//}
//
//+ (CGFloat)getWidth:(float)width{
//    float w;
//    if (IS_IPHONE4) {
//        w = WIDTH_4_MAX_SCALE(width);
//    }else if (IS_IPHONE5){
//        w = WIDTH_5_MAX_SCALE(width);
//    }else if (IS_IPHONE6){
//        w = width;
//    }else if (IS_IPHONE6P){
//        w = WIDTH_6P_MAX_SCALE(width);
//    }
//    return w;
//}



+ (NSString *)StringSecurity:(NSString *)string{
//    NSString *str = [NSString stringWithFormat:@"%@",string];
    
    if (![string isEqual:[NSNull null]]&&![string isEqualToString:@""]) {
        
        return string;
    }else{
        return @"";
    }
    
}

@end
