//
//  UIView+AFAcitivityIndicator.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>


enum AFProgressPosition {
    AFProgressCenterPosition = 1,
    AFProgressTopPosition = 2,
    AFProgressButtomPosition = 3,
    AFProgressDefaultPosition
};
typedef NSUInteger AFProgressPosition;


@interface UIView (AFAcitivityIndicator)



//显示提示信息 ，显示时间（s/秒），显示位置
- (void)makeProgress:(NSString *)message duration:(CGFloat)duration postion:(AFProgressPosition)zPosition;


//显示提示信息，标题，显示时间（s/秒），显示位置
- (void)makeProgress:(NSString *)message title:(NSString *)title duration:(CGFloat)duration postion:(AFProgressPosition)zPosition;

//显示提示信息，显示图片，显示位置
- (void)showImage:(UIView *)image duration:(CGFloat)interval;

//添加加载框
- (void)makeActivityIndicator:(NSString *)message;


//移除加载框
- (void)hideActivityIndicator;


@end
