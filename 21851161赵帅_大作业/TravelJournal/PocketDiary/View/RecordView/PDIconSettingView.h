//
//  PDIconSettingView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PDIconSettingNormalImageKey     @"PDIconSettingNormalImageKey"
#define PDIconSettingSelectedImageKey     @"PDIconSettingSelectedImageKey"

@interface PDIconSettingView : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;
@property (nonatomic, weak) IBOutlet UIButton *button4;
@property (nonatomic, weak) IBOutlet UIButton *button5;
@property (nonatomic, weak) IBOutlet UIButton *button6;
@property (nonatomic, weak) IBOutlet UIButton *button7;
@property (nonatomic, weak) IBOutlet UIButton *button8;

- (void)setIconsWithDictArray:(NSArray *)dictArray;
- (void)setSettingViewTitle:(NSString *)title;
- (NSArray *)getRecordButtons;

@end
