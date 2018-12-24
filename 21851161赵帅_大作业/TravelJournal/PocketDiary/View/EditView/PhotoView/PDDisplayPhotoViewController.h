//
//  PDDisplayPhotoViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDDisplayPhotoViewControllerDelegate <NSObject>



@end

@interface PDDisplayPhotoViewController : UIViewController

@property (nonatomic, assign) id<PDDisplayPhotoViewControllerDelegate> delegate;

- (id)initWithPhotoDatas:(NSArray *)photoDatas;

@end
