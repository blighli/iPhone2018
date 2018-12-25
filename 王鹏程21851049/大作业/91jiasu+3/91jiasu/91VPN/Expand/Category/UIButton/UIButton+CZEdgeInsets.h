//
//  UIButton+CZEdgeInsets.h
//  UIButton-CZEdgeInsets
//
//  Created by 百纬 on 2016/11/8.
//  Copyright © 2016年 weichengzong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CZEdgeInsetsStyle){
    CZButtonEdgeInsetsStyleImageLeft,
    CZButtonEdgeInsetsStyleImageRight,
    CZButtonEdgeInsetsStyleImageTop,
    CZButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (CZEdgeInsets)

- (void)czButtonWithEdgeInsetsStyle:(CZEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end
