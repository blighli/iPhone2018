//
//  UIView+Border.m
//  ExpressProject
//
//  Created by Mackellen on 14/12/7.
//  Copyright (c) 2014年 Mackellen. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}
- (void)drawDashedBorder:(UIColor *)color cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth dashPattern:(CGFloat)dashPattern spacePattern:(CGFloat)spacePattern
{
    CAShapeLayer *_shapeLayer=[CAShapeLayer layer];
//    if (_shapeLayer) [_shapeLayer removeFromSuperlayer];
    CGRect frame = self.bounds;
    
    //border definitions
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    _shapeLayer.path = path;
    CGPathRelease(path);
    
    _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapeLayer.frame = frame;
    _shapeLayer.masksToBounds = NO;
    [_shapeLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.strokeColor = [color CGColor];
    _shapeLayer.lineWidth = borderWidth;//边框宽度
    
    _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:dashPattern], [NSNumber numberWithInt:spacePattern], nil];//边框间距  边框线长
    _shapeLayer.lineCap = kCALineCapRound;
    
    //_shapeLayer is added as a sublayer of the view
    [self.layer addSublayer:_shapeLayer];
    self.layer.cornerRadius = cornerRadius;
    
    
    
}

- (void)setAnimationWithType:(AnimationType)animation duration:(float)s direction:(Direction)d{
    CATransition*ani=[CATransition animation];
    
    ani.duration = s;
    switch (d) {
        case CHDleft:
            ani.subtype = kCATransitionFromLeft;
            break;
        case CHDright:
            ani.subtype = kCATransitionFromRight;
            break;
        case CHDtop:
            ani.subtype = kCATransitionFromTop;
            break;
        case CHDbottom:
            ani.subtype = kCATransitionFromBottom;
            break;
            
        case CHDmiddle:
            ani.subtype = kCATruncationMiddle;
            break;
        default:
            break;
    }
    switch (animation) {
        case CHDpageCurl:
        {
            ani.type = @"pageCurl";
        }
            break;
        case CHDpageUnCurl:
        {
            ani.type = @"pageUnCurl";
        }
            break;
        case CHDrippleEffect:
        {
            ani.type = @"rippleEffect";
        }
            break;
        case CHDsuckEffect:
        {
            ani.type = @"suckEffect";
        }
            break;
        case CHDcube:
        {
            ani.type = @"cube";
        }
            break;
        case CHDcameraIrisHollowOpen:
        {
            ani.type = @"cameraIrisHollowOpen";
        }
            break;
        case CHDoglFlip:
        {
            ani.type = @"oglFlip";
        }
            break;
        case CHDcameraIrisHollowClose:
        {
            ani.type = @"cameraIrisHollowClose";
            
        }break;
        case CHDmovein:
            ani.type = kCATransitionMoveIn;
            break;
        case CHDpush:
            ani.type = kCATransitionPush;
            break;
        case CHDfade:
            ani.type = kCATransitionFade;
            break;
            
        default:
            break;
    }
    [self.layer addAnimation:ani forKey:nil];
    
    
}


@end
