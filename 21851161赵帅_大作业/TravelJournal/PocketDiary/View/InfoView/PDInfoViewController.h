//
//  PDInfoViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDInfoViewController;

@protocol PDInfoViewControllerDelegate <NSObject>

@required
- (void)infoViewController:(PDInfoViewController *)infoViewController dismissAndEnterPieceViewWithDate:(NSDate *)date;

@end

@interface PDInfoViewController : UIViewController

@property (nonatomic, weak) id<PDInfoViewControllerDelegate> delegate;

- (id)initWithDate:(NSDate *)date;

@end
