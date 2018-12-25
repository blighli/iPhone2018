//
//  CZTabBar.m
//  91VPN
//
//  Created by weichengzong on 2017/10/11.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZTabBar.h"

@implementation CZTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOpacity = 0.4;//阴影透明度，默认0
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowRadius = 4;//阴影半径，默认3
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, -2)];
        [path addLineToPoint:CGPointMake(SCREEN_WIDTH, -2)];
        [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 1)];
        [path addLineToPoint:CGPointMake(0, 1)];
        [path addLineToPoint:CGPointMake(0, -2)];
        
        self.layer.shadowPath = path.CGPath;
        //影藏横线
        [self setBackgroundImage:[UIImage new]];
        [self setShadowImage:[UIImage new]];
    }
    return self;
}

@end
