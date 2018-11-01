//
//  ViewController.m
//  TaskList
//
//  Created by 王玉金 on 2018/10/26.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "TaskData+CoreDataClass.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

@property(strong,nonatomic) NSMutableArray *taskArray;

@property(strong,nonatomic) NSArray *arr;

@end

@implementation ViewController

#pragma mark - 打开程序从数据库加载保存之前保存的task
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //应用启动的时候加载数据库文件
    NSManagedObjectContext *context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] initWithEntityName:@"TaskData"];
    self.arr = [context executeFetchRequest:fetchData error:nil];
    
    self.taskArray = [[NSMutableArray alloc] initWithArray:[self.arr valueForKey:@"taskName"]];
}
#pragma mark - UITableViewDataSource
//每一个section有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - 点击Insert按钮
- (IBAction)addTaskButtonClick:(id)sender {

    NSString *inputStr = [[NSMutableString alloc] initWithFormat:@"%@",self.inputTextField.text];
    inputStr = [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //判断如果输入的为空，则不添加；
    if ([inputStr  isEqual: @""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else {
        //每点击一次“确定”按钮后，就把该数据存储到CoreData中；
        [self saveToCoreData:inputStr];
        
        //把一个文本存储到taskArray数组中；
        [self.taskArray insertObject:self.inputTextField.text atIndex:self.taskArray.count];
        [self.taskTableView reloadData];
        
        //清空输入框；
        self.inputTextField.text = nil;
        //点击确定后消失软键盘；
        [self.inputTextField resignFirstResponder];
    }
}
#pragma mark - 保存数据到 CoreData
- (void) saveToCoreData:(NSString *)taskName{
    
    NSManagedObjectContext *context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObject *row = [NSEntityDescription insertNewObjectForEntityForName:@"TaskData" inManagedObjectContext:context];
    
    [row setValue:taskName forKey:@"taskName"];
    [context save:nil];
    NSLog(@"已保存到数据库");
}

#pragma mark - 删除数据 from CoreData
- (void) deleteToCoreData:(NSString *)deleteTaskName{
    NSManagedObjectContext *context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    //创建删除请求
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"TaskData"];
    //删除条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"taskName == %@", deleteTaskName];
    deleRequest.predicate = pre;
    //返回需要删除的对象数组
    NSArray *deleArray = [context executeFetchRequest:deleRequest error:nil];
    //从数据库中删除 删除所有 如果加break，则只会删除一个
    for (TaskData *stu in deleArray) {
        [context deleteObject:stu];
        //break;
    }
    //保存
    [context save:nil];
    NSLog(@"删除成功");
}

#pragma mark - UIScrollViewDelegate
//滚动TableView的时候隐藏软键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.inputTextField resignFirstResponder];
}

#pragma mark - 手势滑动删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;//手势滑动删除
}
#pragma mark - 删除cell和数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        //获取cell内容
        NSString *item = [self.taskArray objectAtIndex: indexPath.row];
        NSLog(@"delete the cell name:%@",item);
        
        //从sqlite数据库中删除
        [self deleteToCoreData: item];
        //从taskarray中删除
        [self.taskArray removeObjectAtIndex:indexPath.row];
        //再将此条cell从列表删除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //刷新列表
        [self.taskTableView reloadData];
        //NSLog(@"删除成功！");
    }
}

@end
