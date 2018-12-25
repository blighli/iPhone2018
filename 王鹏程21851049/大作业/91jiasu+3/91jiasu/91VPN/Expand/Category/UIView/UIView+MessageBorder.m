//
//  UIView+MessageBorder.m
//  GoPanda
//
//  Created by wangpengfei on 16/1/7.
//  Copyright © 2016年 wangpengfei. All rights reserved.
//

#import "UIView+MessageBorder.h"

@implementation UIView (MessageBorder)



- (void)shouMessageBorder:(NSString *)message image_name:(NSString *)image_name  show_time:(float)show_time postion:(AFPositionType)postion{
    
    switch (postion) {
        case AFPositionTypeCenter:
            [self initMessageCenterView:message imagename:nil time:show_time];
            break;
        case AFPositionTypeTop:
            [self initMessageTopView:message imagename:image_name time:show_time];
            break;

            
        default:
            break;
    }
    
    
}

- (void)initMessageTopView:(NSString *)message imagename:(NSString *)imagename time:(float)time{
    // 创建父View
    UIView *parentView = [[UIView alloc] init];
    [parentView setBackgroundColor:[UIColor redColor]];
    [parentView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 25)];
    [parentView setAlpha:0];
    [self addSubview:parentView];
    //错误提示内容
    UILabel *textlab=[[UILabel alloc]init];
    [textlab setFont:[UIFont systemFontOfSize:12.0f]];
    [textlab setTextColor:[UIColor whiteColor]];
    [textlab setTextAlignment:NSTextAlignmentCenter];
    [textlab setNumberOfLines:0];
    [textlab setText:[NSString stringWithFormat:@"X %@",message]];
    UIImage *image=[UIImage imageNamed:imagename];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(textlab.frame)+2.5, 0, image.size.width, image.size.height)];
    [imageview setImage:image];
    [parentView addSubview:imageview];
    [parentView addSubview:textlab];
    
    
    [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [textlab setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
        parentView.alpha=0.8;
    } completion:^(BOOL finished) {

    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [parentView removeFromSuperview];
    });


}
- (void)initMessageCenterView:(NSString *)message imagename:(NSString *)imagename time:(float)time{
    CGRect rectToFit = [message boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-160, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]} context:nil];
    
    UIView *parentView = [[UIView alloc] init];
    [parentView setFrame:CGRectZero];
    [parentView setBackgroundColor:[UIColor blackColor]];
    parentView.center=kKeyWindow.center;
    [parentView setAlpha:0.0];
    [parentView setMultipleTouchEnabled:YES];
    [parentView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [parentView.layer setShadowRadius:2.0f];
    [parentView.layer setCornerRadius:8];
    [self addSubview:parentView];

    
    //标题
    UILabel *titletlab=[[UILabel alloc]init];
    [titletlab setFrame:CGRectMake(10, 0, SCREEN_WIDTH-160, 40)];
    [titletlab setFont:[UIFont systemFontOfSize:15.0f]];
    [titletlab setTextColor:[UIColor whiteColor]];
    [titletlab setTextAlignment:NSTextAlignmentCenter];
    [titletlab setNumberOfLines:0];
    [titletlab setText:@"温馨提示"];
    [parentView addSubview:titletlab];

    //提示内容
    UILabel *textlab=[[UILabel alloc]init];
    [textlab setFrame:CGRectMake(10, CGRectGetMaxY(titletlab.frame), SCREEN_WIDTH-160, rectToFit.size.height)];
    [textlab setFont:[UIFont systemFontOfSize:13.0f]];
    [textlab setTextColor:[UIColor whiteColor]];
    [textlab setTextAlignment:NSTextAlignmentCenter];
    [textlab setNumberOfLines:0];
    [textlab setText:message];
    [parentView addSubview:textlab];
    
    [UIView animateWithDuration:1.0 animations:^{
        parentView.alpha=0.6;

        [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{

            [parentView setFrame:CGRectMake(0, 0, SCREEN_WIDTH-140, rectToFit.size.height+60)];

            parentView.center=kKeyWindow.center;

            
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
        
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [parentView removeFromSuperview];
    });

}

@end
