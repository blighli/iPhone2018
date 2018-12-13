//
//  ViewController.m
//  tasklist
//
//  Created by dxy on 2018/10/28.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import "ViewController.h"
#import "Store.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TaskInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *InsertButton;
@property (weak, nonatomic) IBOutlet UITableView *TaskListTableView;
- (IBAction)onInsert:(id)sender;
- (void)saveData;
- (void)readData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 读取数据
    [self readData];
    
    // 监听 App 进入后台事件
    SEL save = NSSelectorFromString(@"saveData");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:save name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)readData{
    // 从 plist 中读取数据并更新到 taskList 变量中
    NSLog(@"读取数据");
    store = [[Store alloc] initWithName:@"user"];
    taskList = [store readPlist];
}

-(void)saveData{
    // 将 taskList 变量中的数据写回 plist
    NSLog(@"保存数据");
    [store savePlist:taskList];
}

#pragma mark - Table View Data source
- (IBAction)onInsert:(id)sender {
    NSString *text = [self.TaskInputTextField.text copy];
    if([text length]>0){
        [taskList addObject:text];
        // 更新 tableview
        [self.TaskListTableView reloadData];
        self.TaskInputTextField.text = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [taskList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"task";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *stringForCell;
    if (indexPath.section == 0) {
        stringForCell= [taskList objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:stringForCell];
    return cell;
}
@end
