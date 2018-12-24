//
//  UIImage+Image.h
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/12/10.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype)imageOriginalWithName:(NSString *)imageName;

- (instancetype)circleImage;

+ (instancetype)circleImageNamed:(NSString *)name;
@end
