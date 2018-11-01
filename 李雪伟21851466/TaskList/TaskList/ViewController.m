//
//  ViewController.m
//  TaskList
//
//  Created by M David on 18-10-26.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setTitle:(id)sender {
    [myTitleLable setText:@"hello"];
}
@end
