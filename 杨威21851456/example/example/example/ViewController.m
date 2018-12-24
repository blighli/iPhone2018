//
//  ViewController.m
//  example
//
//  Created by 杨威 on 2018/12/11.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"
#import "PointViewController.h"
#import "NavigationViewController.h"
#import "LoginController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden       = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbarHidden             = YES;
}

-(void)setupUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"账号管理";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"定位当前位置";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"点击标记显示地址";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"导航";
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LoginController *loginvc = [[LoginController alloc]init];
        [self.navigationController pushViewController:loginvc animated:YES];
    }else if(indexPath.row == 1){
        LocationViewController *locatvc = [[LocationViewController alloc]init];
        [self.navigationController pushViewController:locatvc animated:YES];
    }else if(indexPath.row == 2){
        PointViewController *pointvc = [[PointViewController alloc]init];
        [self.navigationController pushViewController:pointvc animated:YES];
    }else if(indexPath.row == 3){
        NavigationViewController *navivc = [[NavigationViewController alloc]init];
        [self.navigationController pushViewController:navivc animated:YES];
    }
}
@end

