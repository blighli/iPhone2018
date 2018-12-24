//
//  PDRecordDateView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDRecordDateViewDelegate <NSObject>

- (void)enterSettingDateView;

@end

@interface PDRecordDateView : UIView

@property (nonatomic, assign) id<PDRecordDateViewDelegate> delegate;

- (void)setDateStringWithDate:(NSDate *)date;

@end
