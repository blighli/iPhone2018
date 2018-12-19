//
//  PDPieceEditToolbar.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDPieceEditToolbarDelegate <NSObject>

@optional
- (void)returnPieceView;
- (void)showImagePicker;
- (void)previousPieceCellEditView;
- (void)nextPieceCellEditView;

@end

@interface PDPieceEditToolbar : UIView

@property (nonatomic, assign) id<PDPieceEditToolbarDelegate> delegate;

- (void)setLeftBtnEnabled:(BOOL)enabled;
- (void)setRightBtnEnabled:(BOOL)enabled;

@end
