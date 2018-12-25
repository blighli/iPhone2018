//
//  UIView+AFAcitivityIndicator.m
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import "UIView+AFAcitivityIndicator.h"
#import <objc/runtime.h>


#define DEVICE_SCREEN [[ UIScreen mainScreen ] bounds].size

//static const  BOOL  isShowProgress;
static const  BOOL  isDisplayShadow = YES;

// image view size
static const CGFloat MKImageViewWidth      =  80.0;
static const CGFloat MKImageViewHeight     =  80.0;

// activity
static const CGFloat MKActivityViewWidth       = 100.0;
static const CGFloat MKActivityViewHeight      = 100.0;


//title Label margin
static const CGFloat MKTitleMarginSize   =   10.0;
static const CGFloat MKMessagePrecentage  =  0.8;

static const NSString *MKActivityViewKey  =  @"MKActivityViewKey";

@implementation UIView (AFAcitivityIndicator)



//显示提示信息 ，显示时间（s/秒），显示位置
- (void)makeProgress:(NSString *)message duration:(CGFloat)duration postion:(AFProgressPosition)zPosition{
    UIView *progressView = [self viewForMessage:message title:nil image:nil];
    [self showProgress:progressView duration:duration position:zPosition];
}


//显示提示信息，标题，显示时间（s/秒），显示位置
- (void)makeProgress:(NSString *)message title:(NSString *)title duration:(CGFloat)duration postion:(AFProgressPosition)zPosition{
    UIView *progressView = [self viewForMessage:message title:title image:nil];
    [self showProgress:progressView duration:duration position:zPosition];
}


- (void)showImage:(UIView *)image duration:(CGFloat)interval{
    image.alpha = 0.0;
    [self addSubview:image];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                image.alpha = 1.0;
    } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.2 delay:interval options:UIViewAnimationOptionCurveEaseIn animations:^{
                image.alpha = 0.0;
         } completion:^(BOOL finished) {
                [image removeFromSuperview];
         }];
    }];
}



//计算出显示位置
- (CGPoint)showPointForPosition:(AFProgressPosition)zPosition progessView:(UIView *)progressView{
    if (zPosition == AFProgressCenterPosition) {
        return CGPointMake(DEVICE_SCREEN.width/2, DEVICE_SCREEN.height/2);
    }else if (zPosition == AFProgressTopPosition){
        return CGPointMake(DEVICE_SCREEN.width/2, 30);
    }else if (zPosition == AFProgressButtomPosition){
        return CGPointMake(DEVICE_SCREEN.width/2, DEVICE_SCREEN.height - progressView.frame.size.height - 60);
    }else{
        return CGPointMake(DEVICE_SCREEN.width/2, DEVICE_SCREEN.height - progressView.frame.size.height - 60);
    }
    return CGPointZero;
}



//显示的View，显示时间（s/秒），显示位置
- (void)showProgress:(UIView *)progressView duration:(CGFloat)duration position:(AFProgressPosition)zPostion{
    progressView.center = [self showPointForPosition:zPostion progessView:(UIView *)progressView];
    progressView.alpha = 0.0;
    [self addSubview:progressView];
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        progressView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:duration options:UIViewAnimationOptionCurveEaseIn animations:^{
            progressView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [progressView removeFromSuperview];
        }];
    }];
}


- (void)makeActivityIndicator:(NSString *)message{
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &MKActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MKActivityViewWidth, MKActivityViewHeight)];
    activityView.center = [self showPointForPosition:AFProgressCenterPosition progessView:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = MKTitleMarginSize;
    //添加阴影效果
    if (isDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = 0.8;
        activityView.layer.shadowRadius = 6.0;
        activityView.layer.shadowOffset = CGSizeMake(4.0, 4.0);
    }
    
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.frame.size.width/2, activityView.frame.size.height/2);
    activityIndicatorView.color = [UIColor whiteColor];
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    UILabel *messageLabel = nil;
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // 计算出message 宽度以及高度
        CGSize maxSizeTitle = CGSizeMake(MKActivityViewWidth * MKMessagePrecentage, MKActivityViewHeight * MKMessagePrecentage);
        CGSize expectedSizeTitle;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
        expectedSizeTitle = [message sizeWithFont:messageLabel.font constrainedToSize:maxSizeTitle lineBreakMode:messageLabel.lineBreakMode];
#else
        NSDictionary *attribute = @{NSFontAttributeName: messageLabel.font};
        expectedSizeTitle = [message boundingRectWithSize:maxSizeTitle options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
#endif
        
        messageLabel.frame = CGRectMake((MKActivityViewWidth-expectedSizeTitle.width)/2, MKActivityViewHeight-expectedSizeTitle.height-MKTitleMarginSize, expectedSizeTitle.width, expectedSizeTitle.height);
        [activityView addSubview:messageLabel];
        activityIndicatorView.center = CGPointMake(activityView.frame.size.width/2, activityView.frame.size.height/2-MKTitleMarginSize);
    }
    
    
    objc_setAssociatedObject(self, &MKActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:activityView];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        activityView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}


- (void)hideActivityIndicator{
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &MKActivityViewKey);
    if (existingActivityView) {
        [UIView animateWithDuration:0.3 delay:0.0 options:(UIViewAnimationOptionCurveEaseIn| UIViewAnimationOptionBeginFromCurrentState) animations:^{
            existingActivityView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [existingActivityView removeFromSuperview];
            objc_setAssociatedObject(self, &MKActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
    }else{
        [existingActivityView removeFromSuperview];
    }
}


//绘制提示内容
- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // 判断空情况
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // 有消息，有标题，有图片
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // 创建父View
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = MKTitleMarginSize;
    //添加阴影效果
    if (isDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = 0.8;
        wrapperView.layer.shadowRadius = 6.0;
        wrapperView.layer.shadowOffset = CGSizeMake(4.0, 4.0);
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:MKMessagePrecentage];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(MKTitleMarginSize, MKTitleMarginSize, MKImageViewWidth, MKImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // imageView视图大小
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = MKTitleMarginSize;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // 计算出title 宽度以及高度
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * MKMessagePrecentage) - imageWidth, self.bounds.size.height * MKMessagePrecentage);
        CGSize expectedSizeTitle;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
        expectedSizeTitle = [title sizeWithFont:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
#else
        NSDictionary *attribute = @{NSFontAttributeName: titleLabel.font};
        expectedSizeTitle = [title boundingRectWithSize:maxSizeTitle options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
#endif
        
        
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:16.0f];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // 计算出message提示信息视图大小
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * MKMessagePrecentage) - imageWidth, self.bounds.size.height * MKMessagePrecentage);
        
        CGSize expectedSizeMessage;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
        expectedSizeMessage = [message sizeWithFont:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
#else
        NSDictionary *attribute = @{NSFontAttributeName: messageLabel.font};
        expectedSizeMessage = [message boundingRectWithSize:maxSizeMessage options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
#endif
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    
    
    // titleLabel视图大小
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = MKTitleMarginSize;
        titleLeft = imageLeft + imageWidth + MKTitleMarginSize;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    
    // messageLabel 视图大小
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + MKTitleMarginSize;
        messageTop = titleTop + titleHeight + MKTitleMarginSize;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // 计算父View 视图大小
    CGFloat wrapperWidth = MAX((imageWidth + (MKTitleMarginSize * 2)), (longerLeft + longerWidth + MKTitleMarginSize));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + MKTitleMarginSize), (imageHeight + (MKTitleMarginSize * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, wrapperView.frame.size.width-titleLeft, titleHeight);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}




@end
