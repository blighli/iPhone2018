//
//  ViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "ViewController.h"
#import "QXBank.h"
#import "QXBankTableViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QXBankTableViewController *bankVC = [[QXBankTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    bankVC.bank = [[QXBank alloc] initWithFileName:@"电影库"];
    self.viewControllers = @[bankVC];
}

@end
