//
//  PDBaseInfoViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/29.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDBaseInfoViewController;

@protocol PDBaseInfoViewControllerDelegate <NSObject>

@required
- (void)baseInfoViewController:(PDBaseInfoViewController *)baseInfoViewController dismissAndEnterPieceViewWithDate:(NSDate *)date;

@end

@interface PDBaseInfoViewController : UIViewController

@property (nonatomic, weak) id<PDBaseInfoViewControllerDelegate> baseVCDelegate;

@end
