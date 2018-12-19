//
//  ViewController.m
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//



#define IMAGE_NAME  @"1.jpg"

#import "ViewController.h"
#import "LTYCustomView.h"
#import "LTYGameViewController.h"
#import "LTYGetSystemPhoto.h"
#import "LTYHeader.h"
#import "LTYWarnLabelView.h"

typedef NS_ENUM(NSUInteger, LTYPhotoType) {
    LTYPhotoTypePhoto,   // 相册
    LTYPhotoTypeCamera   // 相机
};

@interface ViewController () {
    UIImageView *_LTYImageView;  // 底部图片
    NSMutableArray *_dataArray;  // 盛放分割后图片的数组
    UIView *_sizeView;           // 选图片的一块儿区域
    float _sizeOrigin_x;         // 选中区域的横坐标
    float _sizeOrigin_y;         // 选中区域的纵坐标
    float _moveOrigin_x;         // 移动区域时，起始横坐标
    float _moveOrigin_y;         // 移动区域时，起始纵坐标
    UIImage *_choseImage;        // 选中的图片
    UIImageView *_choseImageView;  // 选中的图片橙装的背景（虚拟的，没有加载）
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatLeftRightBarItem];
    [self giveSizeFirstValue];
    [self giveMoveFirstValue];
    [self creatUI];
}
- (void)giveSizeFirstValue {
    _sizeOrigin_x = -1.0f;
    _sizeOrigin_y = -1.0f;
}
- (void)giveMoveFirstValue {
    _moveOrigin_x = -1.0f;
    _moveOrigin_y = -1.0f;
}
#pragma mark - 创建视图方法
- (void)creatUI {
    _LTYImageView = [[UIImageView alloc] init];
    _LTYImageView.frame = CGRectMake(0, 70, kScreenWidth, kScreenWidth);
    _LTYImageView.userInteractionEnabled = YES;
    [self.view addSubview:_LTYImageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [_LTYImageView addGestureRecognizer:pan];
    
    // 选中区域视图
    _sizeView = [[UIView alloc] init];
    _sizeView.layer.borderWidth = 1.0f;
    _sizeView.layer.borderColor = [UIColor redColor].CGColor;
    _sizeView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:_sizeView];
    [self.view.layer addSublayer:_sizeView.layer];
    
    UIPanGestureRecognizer *movePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(movePanAction:)];
    [_sizeView addGestureRecognizer:movePan];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteBtn.frame = CGRectMake((kScreenWidth-100)/2, kScreenWidth+150, 100, 50);
    [deleteBtn setTitle:@"重选" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor yellowColor];
    [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
}

- (void)movePanAction:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self giveMoveFirstValue];
    }
    CGPoint point = [gesture locationInView:self.view];
    float originX = point.x;
    float originY = point.y;
    if (_moveOrigin_x<0) {
        _moveOrigin_x = originX;
        _moveOrigin_y = originY;
    }
    // 移动的距离
    float valueX = originX - _moveOrigin_x;
    float valueY = originY - _moveOrigin_y;
    
    // 底部背景的底部
    float LTY_bottom = _LTYImageView.frame.origin.y+_LTYImageView.frame.size.height;
    // 底部背景的右边
    float LTY_right = _LTYImageView.frame.origin.x+_LTYImageView.frame.size.width;
    // 选取视图的底部
    float size_bottom = _sizeOrigin_y+_sizeView.frame.size.height;
    // 选取视图的右边
    float size_right = _sizeOrigin_x+_sizeView.frame.size.width;
    
    // 防止越界
    
    // 限制左面
    if (-valueX>=_sizeOrigin_x-_LTYImageView.frame.origin.x) {
        valueX = -(_sizeOrigin_x-_LTYImageView.frame.origin.x);
    }
    // 限制上面
    if (-valueY>=_sizeOrigin_y-_LTYImageView.frame.origin.y) {
        valueY = -(_sizeOrigin_y-_LTYImageView.frame.origin.y);
    }
    // 限制右面
    if (valueX>LTY_right-size_right) {
        valueX = LTY_right-size_right;
    }
    // 限制下面
    if (valueY>LTY_bottom-size_bottom) {
        valueY = LTY_bottom-size_bottom;
    }
    _sizeView.frame = CGRectMake(_sizeOrigin_x+valueX,_sizeOrigin_y+valueY , _sizeView.frame.size.width, _sizeView.frame.size.height);
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _sizeOrigin_x = _sizeView.frame.origin.x;
        _sizeOrigin_y = _sizeView.frame.origin.y;
    }
}
- (void)panAction:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self giveSizeFirstValue];
    }
    CGPoint point = [gesture locationInView:self.view];
    float originX = point.x;
    float originY = point.y;
    if (_sizeOrigin_x<0) {
        _sizeOrigin_x = originX;
        _sizeOrigin_y = originY;
    }
    _sizeView.frame = CGRectMake(_sizeOrigin_x, _sizeOrigin_y, originX-_sizeOrigin_x, originY-_sizeOrigin_y);
    // 选取视图的底部
    float size_bottom = _sizeOrigin_y+_sizeView.frame.size.height;
    // 底部背景的底部
    float LTY_bottom = _LTYImageView.frame.origin.y+_LTYImageView.frame.size.height;
    
    if (size_bottom > LTY_bottom) {
        _sizeView.frame = CGRectMake(_sizeOrigin_x, _sizeOrigin_y, originX-_sizeOrigin_x, LTY_bottom-_sizeOrigin_y);
    }
}

#pragma mark - 左右导航按钮方法
- (void)creatLeftRightBarItem {
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"选择图片" style:UIBarButtonItemStylePlain target:self action:@selector(choseImage)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"开始拼图" style:UIBarButtonItemStylePlain target:self action:@selector(beginGame)];
    
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark - 选择图片方法
- (void)choseImage {
    LTYGetSystemPhoto *photo = [[LTYGetSystemPhoto alloc] init];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"亲,开始选择吧?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        photo.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photo.myImageBlock = ^(UIImage *image) {
            [self clipsOldImage:image];
        };
        [self.navigationController pushViewController:photo animated:NO];
    }];
    
    UIAlertAction *caremaAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        photo.sourceType = UIImagePickerControllerSourceTypeCamera;
        photo.myImageBlock = ^(UIImage *image) {
            [self clipsOldImage:image];
        };
        [self.navigationController pushViewController:photo animated:NO];
    }];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clipsOldImage:[UIImage imageNamed:IMAGE_NAME]];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:photoAction];
    [alert addAction:caremaAction];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 开始游戏的方法
- (void)beginGame {
    if (_LTYImageView.image == nil) {
        [LTYWarnLabelView warnLabelWithTitle:@"请选择图片!"];
        return;
    }
    [self captureImages];
    LTYGameViewController *vc = [[LTYGameViewController alloc] init];
    vc.originImage = _choseImage;
    vc.dataArray = _dataArray;
    vc.totalFrame = _choseImageView.frame;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取分割小图片的方法
- (void)captureImages {
    float sizeViewWidth = _sizeView.frame.size.width;
    float sizeViewHeight = _sizeView.frame.size.height;
    _choseImageView = [[UIImageView alloc] init];
    if (sizeViewWidth > 0) {
        // 存在，需要截取选中的图片
        _choseImage = [LTYCustomView captureImageWithView:_LTYImageView andClipRect:CGRectMake(_sizeView.frame.origin.x, _sizeView.frame.origin.y-_LTYImageView.frame.origin.y, sizeViewWidth, sizeViewHeight)];
        _choseImageView.frame = _sizeView.frame;
    }else {
        // 不存在，直接用原图
        _choseImage = _LTYImageView.image;
        _choseImageView.frame = _LTYImageView.frame;
    }
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    float choseImage_Width = _choseImageView.frame.size.width;
    float choseImage_height = _choseImageView.frame.size.height;
    _choseImageView.image = [self imageWithImageSimple:_choseImage scaledToSize:CGSizeMake(choseImage_Width, choseImage_height)];
    for (NSInteger i = 0; i<9; i++) {
        UIImage *image = [LTYCustomView captureImageWithView:_choseImageView andClipRect:CGRectMake((choseImage_Width/3)*(i%3), (choseImage_height/3)*(i/3), choseImage_Width/3, choseImage_height/3)];
        [_dataArray addObject:image];
    }
}

/**
 *由于原图过于不标准
 *把不规则的图片处理一下
 *处理成300*300
 *该方法很实用
 */
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect : CGRectMake (0 ,0 ,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (void)clipsOldImage:(UIImage *)oldImage {
    UIImage *newImage = [self imageWithImageSimple:oldImage scaledToSize:CGSizeMake(kScreenWidth, kScreenWidth)];
    _LTYImageView.image = newImage;
    
}
- (void)deleteClick {
    _sizeView.frame = CGRectZero;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

