//
//  LTYCustomView.m
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import "LTYCustomView.h"

@implementation LTYCustomView

+ (UIImage *)captureImageWithView:(UIImageView *)currentView andClipRect:(CGRect)cropRect {
    CGRect cropFrame = currentView.frame;
    CGImageRef imgRef = CGImageCreateWithImageInRect(currentView.image.CGImage, cropRect);
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(cropFrame.size, 0, deviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, cropFrame.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, cropFrame.size.width, cropFrame.size.height), imgRef);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imgRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
