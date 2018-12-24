//
//  shiShiReDianViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "shiShiReDianViewController.h"
#import "ReDianTableViewCell.h"
@interface shiShiReDianViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *data;
@end

@implementation shiShiReDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.list = @[@"曹凯强",@"陈枭磊",@"汤凯凯",@"杨靖",@"林晓蕾"];
    self.data = @[@"动态:勇士连胜终止",@"动态:互联网大会",@"动态:四六级分享",@"动态：服务外包咨询",@"动态:服务外包产品介绍"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *id = @"ReDian";
    ReDianTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:id];
    UIImage *image = [UIImage imageNamed:[self.list objectAtIndex:indexPath.section]];
    cell.TouXiang.image = image;
    cell.Dymanic.text = [self.data objectAtIndex:indexPath.section];
   
    [cell.TouXiang.layer setMasksToBounds:YES];
    //按钮加圆角
    [cell.TouXiang.layer setCornerRadius:45];
    //[self.view bringSubviewToFront:_touxiang];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
