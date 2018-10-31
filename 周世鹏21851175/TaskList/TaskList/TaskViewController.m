//
//  TaskViewController.m
//  TaskList
//
//  Created by HuaDream on 2018/10/29.
//  Copyright © 2018 HuaDream. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@property NSMutableArray *taskData;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet UITextField *taskInput;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    _taskTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.taskTableView addGestureRecognizer: tableViewGesture];
    self.taskInput.returnKeyType = UIReturnKeyDone;
    self.taskInput.delegate = self;
    [self.addButton setEnabled:false];
}

- (IBAction)taskInputEditingChanged:(id)sender {
    if ([_taskInput.text isEqualToString:@""]) {
        [self.addButton setEnabled: false];
    } else {
        [self.addButton setEnabled: true];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskInput resignFirstResponder];
    return YES;
}

- (void)commentTableViewTouchInSide {
    [self.taskInput resignFirstResponder];
}

- (NSString *) getDataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    return [docPath stringByAppendingPathComponent: @"data.plist"];
}

- (void) loadData {
    NSString *filePath = [self getDataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        _taskData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    } else {
        _taskData = [[NSMutableArray alloc] init];
    }
}

- (void) saveData {
    [_taskData writeToFile:[self getDataFilePath] atomically:YES];
}

- (IBAction)AddClick:(id)sender {
    if ([_taskInput.text isEqualToString:@""]) {
        return;
    }
    [_taskData insertObject:_taskInput.text atIndex:0];
    [_taskTableView reloadData];
    _taskInput.text = @"";
    [self.addButton setEnabled: false];
    [self.taskInput resignFirstResponder];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleInsert;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_taskData removeObjectAtIndex:indexPath.row];
        [_taskTableView reloadData];
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _taskData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"234"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"234"];
    }
    cell.textLabel.text = [_taskData objectAtIndex:indexPath.row];
    
    return cell;
}

@end


