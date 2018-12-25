//
//  CZMessageVC.m
//  91VPN
//
//  Created by weichengzong on 2017/10/10.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZMessageVC.h"
#import "CZMessageCell.h"
#import "CZWebVC.h"
static NSString *MessageID = @"MessageID";
@interface CZMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray *dataArr;

@end

@implementation CZMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
}

- (void)requestData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _dataArr = [userDefault objectForKey:@"MessageData"];
    [_tableView reloadData];
    if (_dataArr.count<=0) {
        _tableView.hidden=YES;
    }else{
         _tableView.hidden=NO;
    }
}
- (void)uiConfig{
    UILabel *labelK = [[UILabel alloc] init];
    labelK.text = @"暂无消息";
    [self.view addSubview:labelK];
    [labelK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = CZColorHexString(#f3f3f3);
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CZMessageCell class] forCellReuseIdentifier:MessageID];
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageID forIndexPath:indexPath];
    cell.dataDic = [_dataArr objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int num = indexPath.section%3;
    if (num==0) {
        cell.headLabel.backgroundColor = [UIColor colorWithHexString:@"#62afff"];
    }else if (num==1){
        cell.headLabel.backgroundColor = [UIColor colorWithHexString:@"#ff9e45"];
    }else{
        cell.headLabel.backgroundColor = [UIColor colorWithHexString:@"#a6ce37"];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.section];
    if (!kStringIsEmpty([dic objectForKey:@"url"])) {
        CZWebVC *web = [[CZWebVC alloc] init];
        web.URLString = [dic objectForKey:@"url"];
        [self.navigationController pushViewController:web animated:YES];
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
