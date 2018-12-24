//
//  LTYGameViewController.m
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//

#define ITEM_W   _totalFrame.size.width/3
#define ITEM_H   _totalFrame.size.height/3

#define SUCCESS_WORD  @"恭喜您已通关,请返回再次挑战!"

#import "LTYGameViewController.h"
#import "LTYWarnLabelView.h"
#import "LTYHeader.h"

@interface LTYGameViewController () {
    UIImage *_selectedImage; // 上次图片
    NSInteger _selectedTag;  // 上次tag
    BOOL _success;           // 是否成功
    UIImageView *_originImageView;
}

@end

@implementation LTYGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"开始拼图";
    
    _selectedTag = 0;
    _selectedImage = nil;
    
    [self creatImageView];
    
    [self setUpView];
    
    [self makeWrongLocationView];
    
}

#pragma mark - 创建图片方法
- (void)creatImageView {
    for (NSInteger i = 0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i + 1000;
        //imageView.image = _dataArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake((kScreenWidth-3*ITEM_W-2)/2 + (ITEM_W+1) * (i%3),70+(ITEM_H+1)*(i/3), ITEM_W, ITEM_H);
        [self.view addSubview:imageView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:gesture];
    }
}

- (void)setUpView {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"原图/消失" style:UIBarButtonItemStylePlain target:self action:@selector(lookOldImage)];
    self.navigationItem.rightBarButtonItem = right;
    
    _originImageView = [[UIImageView alloc] init];
    _originImageView.frame = CGRectMake((kScreenWidth-2*ITEM_W)/2, kScreenHeight-2*ITEM_H-20, 2*ITEM_W, 2*ITEM_H);
    _originImageView.image = _originImage;
    _originImageView.hidden = YES;
    [self.view addSubview:_originImageView];
}
#pragma mark - 方法
- (void)lookOldImage {
    static int i = 0;
    if (i%2 == 0) {
        _originImageView.hidden = NO;
    }else {
        _originImageView.hidden = YES;
    }
    i++;
}

#pragma mark - 位置打乱
- (void)makeWrongLocationView {
    NSArray *newArr = @[@0,
                        @1,
                        @2,
                        @3,
                        @4,
                        @5,
                        @6,
                        @7,
                        @8
                        ];
    
    newArr = [newArr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    
    for (NSInteger i = 0; i<newArr.count; i++) {
        [self writeImageWithIndex:i andArray:newArr];
    }
}

- (void)writeImageWithIndex:(NSInteger)index andArray:(NSArray *)array{
    
    NSInteger tagInteger = [array[index] integerValue];
    UIImageView *imageView = [self.view viewWithTag:index+1000];
    imageView.image = _dataArray[tagInteger];
}
#pragma mark - 计算两次点击的图片横纵坐标的差值
- (NSArray *)calculateDeletePartWithLastImageView:(UIImageView *)lastImageView andNowImageView:(UIImageView *)nowImageView {
    
    float lastX = lastImageView.frame.origin.x;
    float lastY = lastImageView.frame.origin.y;
    
    float nowX = nowImageView.frame.origin.x;
    float nowY = nowImageView.frame.origin.y;
    
    float deleteX = nowX - lastX;
    float deleteY = nowY - lastY;
    
    if (deleteY < 0) {
        deleteY = -deleteY;
    }
    if (deleteX < 0) {
        deleteX = -deleteX;
    }
    
    NSNumber *x = [NSNumber numberWithFloat:deleteX];
    NSNumber *y = [NSNumber numberWithFloat:deleteY];
    
    return @[x,y];
}

#pragma mark - 上次图片，第一次点击的图片 赋值过程
- (void)addLastImageViewInfomation:(UIImageView *)lastImageView {
    _selectedImage = lastImageView.image;
    _selectedTag = lastImageView.tag;
}

#pragma mark - 开始交换图片的方法
- (void)beginChangeImagesWithLastImageView:(UIImageView *)lastImageView andNowImageView:(UIImageView *)nowImageView {
    lastImageView.image = nowImageView.image;
    nowImageView.image = _selectedImage;
    _selectedImage = nil;
    _selectedTag = 0;
    [self checkImageIsRight];
}

#pragma mark - 点击图片的时候的判断方法
- (void)tapClick:(UITapGestureRecognizer *)gesture {
    if (_success) {
        [self performSelector:@selector(comeout) withObject:nil afterDelay:0.01];
        return;
    }
    if (_selectedImage == nil) {
        [self addLastImageViewInfomation:(UIImageView *)gesture.view];
    }else {
        UIImageView *nowImageView = (UIImageView *)gesture.view;
        UIImageView *lastImageView = [self.view viewWithTag:_selectedTag];
        NSArray *deleteArray = [self calculateDeletePartWithLastImageView:lastImageView andNowImageView:nowImageView];
        
        float deleteX = [deleteArray[0] floatValue];
        float deleteY = [deleteArray[1] floatValue];
        if (deleteX < ITEM_W+5 && deleteX > ITEM_W-5) {
            
            if (deleteY == 0) {
                // 横向移动了
                [self beginChangeImagesWithLastImageView:lastImageView andNowImageView:nowImageView];
            }else {
                // 不合格的移动方式
                [self addLastImageViewInfomation:(UIImageView *)gesture.view];
            }
        } else if (deleteX == 0) {
            if (deleteY < ITEM_H+5 && deleteY > ITEM_H-5) {
                [self beginChangeImagesWithLastImageView:lastImageView andNowImageView:nowImageView];
            }else {
                // 不合格的移动方式
                [self addLastImageViewInfomation:(UIImageView *)gesture.view];
            }
        }else {
            // 不合格的移动方式
            [self addLastImageViewInfomation:(UIImageView *)gesture.view];
        }
    }
}
- (void)checkImageIsRight {
    
    BOOL right = YES;
    
    for (NSInteger i = 0; i<_dataArray.count; i++) {
        UIImageView *imageView = [self.view viewWithTag:1000+i];
        UIImage *image = _dataArray[i];
        if (imageView.image != image) {
            right = NO;
        }
    }
    
    if (right) {
        [self performSelector:@selector(comeout) withObject:nil afterDelay:0.01];
        _success = YES;
    }
    
}
- (void)comeout {
    [LTYWarnLabelView warnLabelWithTitle:SUCCESS_WORD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
