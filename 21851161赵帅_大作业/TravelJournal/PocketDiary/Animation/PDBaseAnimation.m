//
//  PDBaseAnimation.m
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/23.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDBaseAnimation.h"

@implementation PDBaseAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

@end
