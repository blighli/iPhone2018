//
//  CZQuestionVC.m
//  91VPN
//
//  Created by weichengzong on 2017/10/13.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZQuestionVC.h"
#import "CZQ1VC.h"
#import "CZQ2VC.h"

@interface CZQuestionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *dataArr;

@end

@implementation CZQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
}
- (void)uiConfig{
    _dataArr = @[@[@"wenhao",@"使用教程"],@[@"wenhao",@"为什么“连不上”"]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"questionID"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionID" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[_dataArr objectAtIndex:indexPath.row] lastObject];
    cell.imageView.image = [UIImage imageNamed:[[_dataArr objectAtIndex:indexPath.row] firstObject]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CZQ1VC *vc1 = [[CZQ1VC alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    }else if (indexPath.row==1){
        CZQ2VC *vc2 = [[CZQ2VC alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
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
