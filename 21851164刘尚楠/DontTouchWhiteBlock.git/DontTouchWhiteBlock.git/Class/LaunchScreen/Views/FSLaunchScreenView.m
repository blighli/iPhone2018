//
//  FFLaunchScreenView.m
//  Nitrogen
//
//  Created by czy on 2018/12/2.
//  Copyright © 2018年 czy. All rights reserved.
//

#import "FSLaunchScreenView.h"

@interface FSLaunchScreenView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *skipButton;

@end

@implementation FSLaunchScreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = ({
            UIImageView *view = [UIImageView new];
            view.image = [UIImage imageNamed:_L(@"launch_background")];
            view.userInteractionEnabled = YES;
            view.frame = [UIScreen mainScreen].bounds;
            view;
        });
        
        _skipButton = ({
            UIButton *view = [UIButton new];
            [view setTitle:@"跳过" forState:UIControlStateNormal];
            [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [view setBackgroundColor:[UIColor grayColor]];
            view.frame = CGRectMake(ScreenW - 75 - 20, 20, 75, 45);
            view.hidden = YES;
            view;
        });
        
        [self addSubview:_imageView];
        [self addSubview:_skipButton];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)];
        [_imageView addGestureRecognizer:tap];
        
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self performSelector:@selector(skipButtonClick) withObject:self afterDelay:2.5];
    }
    return self;
}

- (void)imageViewClick
{
    if ( self.launchComplete ) {
        self.launchComplete(@"");
    }
}

- (void)skipButtonClick
{
    if ( self.launchComplete ) {
        self.launchComplete(@"");
    }
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"---dealloc---%@", NSStringFromClass([self class]));
#endif
}

@end
