//
//  MainViewController.m
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import "MainViewController.h"
#import "ClassicController.h"
#import "JieJiViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showClassicVc {
    ClassicController *vc = [[ClassicController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)showJieJi {
    JieJiViewController *vc = [[JieJiViewController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
}
- (IBAction)showRank:(id)sender {
    
}
- (IBAction)showAbout {
}

@end
