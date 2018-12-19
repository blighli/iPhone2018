//
//  LTYGameViewController.h
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTYGameViewController :UIViewController

@property (nonatomic,strong) UIImage *originImage; // 原始图片
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) float imageW;
@property (nonatomic,assign) float imageH;
@property (nonatomic,assign) CGRect totalFrame;  // 原始图片的frame

@end

NS_ASSUME_NONNULL_END
