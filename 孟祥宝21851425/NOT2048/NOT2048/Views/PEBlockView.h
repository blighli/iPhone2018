//
//  PETileView.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PETileAppearanceProviderProtocol;
@interface PEBlockView : UIView

@property (nonatomic) NSInteger tileValue;

@property (nonatomic, weak) id<PETileAppearanceProviderProtocol>delegate;

+ (instancetype)blockForPosition:(CGPoint)position
                     sideLength:(CGFloat)side
                          value:(NSUInteger)value
                   cornerRadius:(CGFloat)cornerRadius;

@end


NS_ASSUME_NONNULL_END
