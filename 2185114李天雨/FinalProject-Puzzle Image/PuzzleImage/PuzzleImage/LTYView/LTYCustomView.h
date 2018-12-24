//
//  LTYCustomView.h
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LTYCustomView : UIView
+ (UIImage *)captureImageWithView:(UIImageView *)currentView andClipRect:(CGRect)cropRect;
@end

NS_ASSUME_NONNULL_END
