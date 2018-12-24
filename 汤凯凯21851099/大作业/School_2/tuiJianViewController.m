//
//  TuiJianViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/12.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "TuiJianViewController.h"

@interface TuiJianViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tuiJian3;
@property (weak, nonatomic) IBOutlet UILabel *tuiJian2;

@property (weak, nonatomic) IBOutlet UILabel *tuiJian1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@end

@implementation TuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tuiJian1.text = @"1";
    self.segment.selectedSegmentIndex = 0;

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
- (IBAction)change:(id)sender {
    NSInteger row = self.segment.selectedSegmentIndex;
    switch (row) {
        case 0:{
            self.tuiJian1.text = @"1";
            break;
        }
        case 1: {
            self.tuiJian1.text = @"2";
            break;
        }
        case 2:{
            self.tuiJian1.text = @"3";
            break;
        }
        default:
            break;
    }
}


@end
