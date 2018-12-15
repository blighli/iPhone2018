//
//  FailViewController.m
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import "FailViewController.h"


@interface FailViewController ()

@end

@implementation FailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)againGame {
    self.buttonClick(YES);
    [self dismissViewControllerAnimated:NO completion:^{}];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:NO completion:^{
        self.buttonClick(NO);
    }];
}

@end
