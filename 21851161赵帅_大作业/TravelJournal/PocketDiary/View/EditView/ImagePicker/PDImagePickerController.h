//
//  PDImagePickerController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDImagePickerController;

@protocol PDImagePickerControllerDelegate <NSObject>

- (void)imagePickerController:(PDImagePickerController *)imagePickerController pickFinishedWithPhotos:(NSArray *)photos;
- (void)imagePickerControllerCancel:(PDImagePickerController *)imagePickerController;

@end

@interface PDImagePickerController : UIViewController

@property (nonatomic, assign) id<PDImagePickerControllerDelegate> delegate;
@property (nonatomic, retain) NSDate *date;     // 相片对应的日期
@property (nonatomic, assign) NSInteger questionID;     // 对应的问题ID

@end
