//
//  UIView+Border.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

//线类型
typedef enum tagBorderType
{
    BorderTypeDashed,
    BorderTypeSolid
}BorderType;



//动画类型
typedef enum{
    CHDpageCurl,
    CHDpageUnCurl,
    CHDrippleEffect,
    CHDsuckEffect,
    CHDcube,
    CHDoglFlip,
    CHDcameraIrisHollowOpen,
    CHDcameraIrisHollowClose,
    CHDfade,
    CHDmovein,
    CHDpush
    
}AnimationType;
typedef enum{
    CHDleft,
    CHDright,
    CHDtop,
    CHDbottom,
    CHDmiddle
    
}Direction;

@interface UIView (Border)

// view添加下边框
- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
// view添加左边框
- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
// view添加右边框
- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
// view添加上边框
- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
// view添加虚线边框
- (void)drawDashedBorder:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth dashPattern:(CGFloat)dashPattern spacePattern:(CGFloat)spacePattern
;
// view添加动画
- (void)setAnimationWithType:(AnimationType)animation duration:(float)s direction:(Direction)direction;

@end
