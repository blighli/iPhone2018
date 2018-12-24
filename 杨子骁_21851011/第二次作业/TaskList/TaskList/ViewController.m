//
//  ViewController.m
//  TaskList
//
//  Created by yang on 2018/10/26.
//  Copyright © 2018 yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property(strong,nonatomic) NSMutableArray *taskArray;
@property(strong,nonatomic) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TaskList.plist"];
    self.taskArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    if(self.taskArray==nil){
    self.taskArray=[[NSMutableArray alloc]initWithArray:[self.arr valueForKey:@"taskname"]];
        


    bool t=[self.taskArray writeToFile:plistPath atomically:YES];
        NSLog(@"%@", t);
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - 点击增加按钮
- (IBAction)addTaskButtonClick:(id)sender {
    NSString *inputStr = [[NSMutableString alloc] initWithFormat:@"%@",self.inputTextField.text];
    inputStr = [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([inputStr  isEqual: @""]) {
    
        
    } else {
        [self.taskArray insertObject:self.inputTextField.text atIndex:self.taskArray.count];
        [self.taskTableView reloadData];
        
        self.inputTextField.text = nil;
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [path objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TaskList.plist"];
        [self.taskArray writeToFile:plistPath atomically:YES];
        
    }
}


@end
