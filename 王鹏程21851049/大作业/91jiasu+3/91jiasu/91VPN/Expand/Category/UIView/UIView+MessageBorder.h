//
//  UIView+MessageBorder.h
//  GoPanda
//
//  Created by wangpengfei on 16/1/7.
//  Copyright © 2016年 wangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MessageBorder)



typedef NS_ENUM(NSUInteger, AFPositionType) {
    AFPositionTypeCenter,
    AFPositionTypeTop,
};

- (void)shouMessageBorder:(NSString *)message image_name:(NSString *)image_name  show_time:(float)show_time postion:(AFPositionType)postion;
@end
