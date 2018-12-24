//
//  LTYGetSystemPhoto.m
//  PuzzleImage
//
//  Created by Loren on 2018/12/10.
//  Copyright © 2018年 Loren. All rights reserved.
//

#define   LTYLOG    NSLog(@"%s",__func__);
#import "LTYGetSystemPhoto.h"


@interface LTYGetSystemPhoto () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LTYGetSystemPhoto
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}

- (void)creatUI {
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.delegate = self;
    pic.sourceType = _sourceType;
    [self presentViewController:pic animated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    LTYLOG
    //NSLog(@"info=%@",info);
    UIImage *select = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_myImageBlock) {
        _myImageBlock(select);
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    LTYLOG
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
