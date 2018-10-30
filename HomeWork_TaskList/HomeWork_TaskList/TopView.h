//
//  TopView.h
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/25.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopView : UIView

@property(nonatomic,strong)UITextField *field;
@property(nonatomic,strong)MyButton *insertBtn;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
