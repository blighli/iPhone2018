//
//  PDPhotoData.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/25.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDPhotoData : NSObject

@property (nonatomic, assign) NSInteger questionID;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) NSInteger photoID;

@end
