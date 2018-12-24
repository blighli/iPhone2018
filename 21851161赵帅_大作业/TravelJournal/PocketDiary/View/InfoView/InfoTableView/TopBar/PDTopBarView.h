//
//  PDTopBarView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/25.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDTopBarViewDelegate <NSObject>

- (void)infoTableViewReturn;

@end

@interface PDTopBarView : UIView

@property (nonatomic, weak) id<PDTopBarViewDelegate> delegate;

- (void)setTitleWithText:(NSString *)text;

@end
