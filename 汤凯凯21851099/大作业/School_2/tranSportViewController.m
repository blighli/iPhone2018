//
//  tranSportViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "tranSportViewController.h"
#import "TranSportTableViewCell.h"
@interface tranSportViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segMent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation tranSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //默认选中
    self.segMent.selectedSegmentIndex = 0;
    // Do any additional setup after loading the view.
    self.Title = @[@"  1.杭师大->西城广场商业区",@"  2.杭师大->古墩路印象城",@"  3.杭师大->文三路华星时代广场（靠近杭师大美术学院古荡湾校区)",@"  4.杭师大->西溪印象城"];
    self.Bus = @[@"乘坐【332】路至【文二西路古墩路口】下车，对面即为西城广场商业区",@"乘坐【332路或286路】至【骆家庄南】换乘【91路】至【杭三大桥】",@"乘坐【332路或286路】至【蒋村公交中心】站换乘【24路】至【天苑花园】站下车，步行至华星时代广场",@"乘坐【467路】至【高教路天目山路西口】站下车至马路对面换乘【356路】至【西溪湿地西区】站下车"];
    self.Taxi = @[@"打的价格：30元左右",@"打的价格：30元左右",@"打的价格：45元左右",@"打的价格：30元左右"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.Final = self.Bus;

}
- (IBAction)change:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if(index == 0) {
        self.Final = self.Bus;
    }
    else{
        self.Final = self.Taxi;
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *id = @"id";
    TranSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    cell.Title.text = [self.Title objectAtIndex:indexPath.section];
    cell.Transport.text = [self.Final objectAtIndex:indexPath.section];
    // NSLog(@"count = %d",[self.Final count]);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
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
