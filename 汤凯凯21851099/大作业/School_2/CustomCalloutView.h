//
//  CustomCalloutView.h
//  游园
//
//  Created by Ray on 15/12/1.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView

@property (nonatomic, strong) UIImage *image;   //图片
@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, copy) NSString *subtitle; //地址

@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;

@end
