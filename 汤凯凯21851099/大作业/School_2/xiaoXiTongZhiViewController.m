//
//  xiaoXiTongZhiViewController.m
//  School_2
//
//  Created by hznucai on 15/12/11.
//  Copyright © 2015年 Mu. All rights reserved.
//

#import "xiaoXiTongZhiViewController.h"

@interface xiaoXiTongZhiViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@end

@implementation xiaoXiTongZhiViewController

- (void)viewDidLoad {
    self.cell1.layer.cornerRadius = 1.5;
    self.cell1.layer.borderWidth = 1;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
