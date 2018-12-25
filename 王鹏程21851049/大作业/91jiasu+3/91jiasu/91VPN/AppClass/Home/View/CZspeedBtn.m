//
//  CZspeedBtn.m
//  91加速
//
//  Created by weichengzong on 2017/8/18.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZspeedBtn.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
@implementation CZspeedBtn


- (instancetype)init{
    if (self = [super init]) {
        _imageView = [[FLAnimatedImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"1"];
        
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _state = btndefaultstate;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)btnAction{
    if (_action) {
        _action();
    }
}

- (void)btndefault{
    _imageView.image = [UIImage imageNamed:@"1"];
    _state = btndefaultstate;
}
- (void)start{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:data];
    _imageView.animatedImage = animatedImg;
    _state = btnstartstate;
}
- (void)btnsuccess{
    _imageView.image = [UIImage imageNamed:@"2"];
    _state = btnsuccessstate;
}
@end
