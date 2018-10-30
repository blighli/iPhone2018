//
//  TopView.m
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/25.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建左边的UITextField
        CGFloat margin_width = 20;//左右两边留出的空白距离
        CGFloat gap = 10;
        self.field = [[UITextField alloc]initWithFrame:CGRectMake(margin_width,0, 220, frame.size.height)];
        [self.field setPlaceholder:@"Type a task,tap insert"];
        [self.field.layer setCornerRadius:5];
        [self.field.layer setBorderWidth:2];
        self.insertBtn.layer.masksToBounds = YES;
        [self.field.layer setBorderColor:[UIColor grayColor].CGColor];
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        self.field.leftViewMode = UITextFieldViewModeAlways;
        self.field.clearButtonMode = UITextFieldViewModeAlways;
        self.field.leftView = leftView;
        [self addSubview:self.field];
        
        //创建右边的button
        self.insertBtn = [MyButton buttonWithType:UIButtonTypeSystem];
        [self.insertBtn setFrame:CGRectMake(CGRectGetMaxX(self.field.frame) + 10, CGRectGetMinY(self.field.frame), frame.size.width - gap -margin_width - CGRectGetMaxX(self.field.frame),frame.size.height)];
        [self.insertBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.insertBtn.layer setCornerRadius:5];
        self.insertBtn.layer.masksToBounds = YES;
        [self.insertBtn.layer setBorderWidth:2];
        [self.insertBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.insertBtn setTitle: @"insert" forState: UIControlStateNormal];
        [self addSubview:self.insertBtn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
