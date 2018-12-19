//
//  PDQuestionDetailViewController.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/27.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDQuestionDetailViewController <NSObject>

@required
- (void)detailViewControllerReturn;
- (void)didSelectedWithDate:(NSDate *)date;

@end

@interface PDQuestionDetailViewController : UIViewController

@property (nonatomic, assign) id<PDQuestionDetailViewController> delegate;

- (id)initWithDataArray:(NSArray *)array titleText:(NSString *)title;

@end
