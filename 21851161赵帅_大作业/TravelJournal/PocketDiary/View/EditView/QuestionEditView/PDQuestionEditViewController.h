//
//  PDQuestionEditViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDPieceCellData;
@class PDQuestionEditViewController;

@protocol PDQuestionEditViewControllerDelegate <NSObject>

- (void)setQuestionContentWithText:(NSString *)text;
- (void)questionEditViewController:(PDQuestionEditViewController *)editViewController editQuestionContentText:(NSString *)text inDate:(NSDate *)date;

@end

@interface PDQuestionEditViewController : UIViewController

@property (nonatomic, retain) id<PDQuestionEditViewControllerDelegate> delegate;

- (id)initWithData:(PDPieceCellData *)data delegate:(id<PDQuestionEditViewControllerDelegate>)delegate;
- (NSString *)getOldQuestionContent;

@end
