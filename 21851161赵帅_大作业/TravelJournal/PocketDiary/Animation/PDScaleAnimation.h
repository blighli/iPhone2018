//
//  PDScaleAnimation.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/23.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDBaseAnimation.h"

@protocol PDScaleAnimationDelegate <NSObject>

- (CGRect)getCurrentItemRect;

@end

@interface PDScaleAnimation : PDBaseAnimation

@property (nonatomic, assign) id<PDScaleAnimationDelegate> delegate;

@end
