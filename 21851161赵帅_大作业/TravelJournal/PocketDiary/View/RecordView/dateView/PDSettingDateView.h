//
//  PDSettingDateView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDSettingDateViewDelegate <NSObject>

@required
- (void)dateSettingCancel;

@end

@interface PDSettingDateView : UIView

@property (nonatomic, assign) id<PDSettingDateViewDelegate> delegate;

- (void)setupWithDate:(NSDate *)date;

@end
