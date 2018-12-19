//
//  LTYGetSystemPhoto.h
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LTYBlock)(UIImage *);

NS_ASSUME_NONNULL_BEGIN

@interface LTYGetSystemPhoto : UIViewController

@property (nonatomic, assign)  UIImagePickerControllerSourceType sourceType;

@property (nonatomic, copy)    LTYBlock myImageBlock;

@end

NS_ASSUME_NONNULL_END
