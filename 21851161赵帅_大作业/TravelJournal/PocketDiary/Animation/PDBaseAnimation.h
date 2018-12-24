//
//  PDBaseAnimation.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/23.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
} PDAnimationType;

@interface PDBaseAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) PDAnimationType animationType;

@end
