//
//  PDGridView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDGridViewDelegate <NSObject>

- (void)showDiaryTableView;
- (void)showGridTableView;
- (void)showPhotoTableView;
- (void)showQuestionTableView;

@end

@interface PDGridView : UIView

@property (nonatomic, assign) id<PDGridViewDelegate> delegate;

@end
