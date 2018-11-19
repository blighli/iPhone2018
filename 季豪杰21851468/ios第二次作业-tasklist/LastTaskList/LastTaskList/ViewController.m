//
//  ViewController.m
//  LastTaskList
//
//  Created by pc－jhj on 2018/10/28.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import "ViewController.h"

NSString *DocPath(){
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pathList[0] stringByAppendingPathComponent:@"data.td"];
}

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskFiled;
- (IBAction)taskAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tasktableview;
@property (nonatomic) NSMutableArray *tasks;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasktableview.dataSource = self;
//    self.tasks = [NSMutableArray array];
    NSArray *plist = [NSArray arrayWithContentsOfFile:DocPath()];
    if(plist){
        self.tasks = [plist mutableCopy];
    }else {
        self.tasks = [NSMutableArray array];
    }
//    CGRect tableFrame = CGRectMake(0,80,200,31);
//
////    self.tasktableview = [[UITableView alloc] initWithFrame:tableFrame  style:UITableViewStylePlain];
////    self.tasktableview.separatorStyle = UITableViewCellSeparatorStyleNone;
////    self.tasktableview.dataSource = self;
////    [self.tasktableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];
};
//
//
//
//
//// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
//// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [self.tasktableview dequeueReusableCellWithIdentifier:@"Cell"];
//
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *item = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = item;

    return cell;
}

- (IBAction)taskAdd:(id)sender {
    NSString *text = [self.taskFiled text];
    if([text length] ==0 ){
        return;
    }
    NSLog(@"what %@",text);
    
    [self.taskFiled setText:@""];
    [self.tasks addObject:text];
    [self.tasktableview reloadData];
    [self.tasks writeToFile:DocPath() atomically:YES];

    [self.taskFiled resignFirstResponder];
}
    
@end
