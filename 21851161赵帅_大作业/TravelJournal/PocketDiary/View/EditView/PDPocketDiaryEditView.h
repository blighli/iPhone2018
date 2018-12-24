//
//  PDPocketDiaryEditView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDPieceCellData;

@protocol PDPocketDiaryEditViewDelegate <NSObject>

@required
- (void)displayPhotos;
- (void)showQuestionEditViewWithData:(PDPieceCellData *)data;

@end

@interface PDPocketDiaryEditView : UIView

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, assign) id<PDPocketDiaryEditViewDelegate> delegate;

- (void)resetEditViewWithShowKeyboardFrame:(CGRect)keyboardFrame;
- (void)resetEditViewByHideKeyboard;
- (void)setEditViewWithData:(PDPieceCellData *)data;
- (void)setQuestionContentWithText:(NSString *)text;
- (void)setupImageViewWithPhotoDatas:(NSArray *)datas;

@end
