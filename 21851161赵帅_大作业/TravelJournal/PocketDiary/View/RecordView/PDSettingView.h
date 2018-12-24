//
//  PDSettingView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDSettingViewDelegate <NSObject>

@required
- (void)settingDone:(id)sender;

@end

@interface PDSettingView : UIView

@property (nonatomic, assign)  id<PDSettingViewDelegate> delegate;

- (void)setupSettingViewWithDate:(NSDate *)date;
- (NSString *)getWeatherSettingString;
- (NSString *)getMoodSettingString;

@end
