//
//  PDRecordViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "ViewController.h"

@class PDRecordViewController;

@protocol PDRecordViewControllerDelegate <NSObject>

- (void)recordViewControllerDismiss:(PDRecordViewController *)recordViewController;

@end

@interface PDRecordViewController : ViewController

@property (nonatomic, assign) id<PDRecordViewControllerDelegate> delegate;

- (id)initWithDate:(NSDate *)date;

@end
