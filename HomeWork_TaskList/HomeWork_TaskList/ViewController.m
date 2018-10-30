//
//  ViewController.m
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/25.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "ViewController.h"
#import "TopView.h"
#import "TaskListTableViewCell.h"
#import "MyButton.h"
#import "TaskModel.h"

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    TaskModel *_taskModel;
    UITableView *_listTableV;
    UITextField *_textField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    _taskModel = [[TaskModel alloc]init];
    [self readArray];
    [super viewDidLoad];
    [self initView];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)initView{
    //创建上方的textFiled和botton
    TopView *topView = [[TopView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
    topView.field.delegate = self;
    _textField = topView.field;
    [topView.insertBtn addTarget:self action:@selector(insertAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:topView];
    
    CGFloat viewGap = 10;
    CGFloat topViewBottomY = CGRectGetMaxY(topView.frame);
    //创建下方的taskList的tableView
    _listTableV = [[UITableView alloc]initWithFrame:CGRectMake(0,topViewBottomY + viewGap,SCREEN_WIDTH, SCREEN_HEIGHT - viewGap - topViewBottomY)];
    _listTableV.delegate =self;
    _listTableV.dataSource = self;
    UIView *footView = [[UIView alloc]init];
    _listTableV.tableFooterView = footView;
    [self.view addSubview:_listTableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _taskModel.taskArr.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    // 根据cell的标识去缓存池中查找可循环利用的cell
    TaskListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    // 如果缓存池找不到对应的cell就新建一个
    if(cell == nil){
        cell = [[TaskListTableViewCell alloc]init];
    }
    //覆盖数据
    cell.textLabel.text = _taskModel.taskArr[indexPath.row];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
    
}

- (void)insertAction{
    if ([_textField.text  isEqual: @""]) {
        return;
    }
    [_taskModel.taskArr addObject:_textField.text];
    [_listTableV reloadData];
    [self saveArray];
    //重置textField中的内容
    _textField.text = @"";
}

- (void)saveArray{
    //获取Documents目录
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //指定存储文件的文件名称,使用字符串拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:@"taskNameArray.plist"];
    //将数组存储到文件中
    [_taskModel.taskArr writeToFile:filePath atomically:YES];
}

- (void)readArray{
    //获取Documents目录
     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //指定存储文件的文件名称,使用字符串拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:@"taskNameArray.plist"];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:filePath];

    for (NSString *tempStr in tempArray) {
        [_taskModel.taskArr addObject:tempStr];
    }
}

@end
