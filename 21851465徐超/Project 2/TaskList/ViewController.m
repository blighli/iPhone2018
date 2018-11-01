//
//  ViewController.m
//  TaskList
//
//  Created by 徐超 on 2018/10/28.
//  Copyright © 2018 徐超. All rights reserved.
//

#import "ViewController.h"

#define SANDBOX_DOCUMENT_PATH   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define DEFAULT_FILE_MANAGER    [NSFileManager defaultManager]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listTableView.dataSource = self;
    self.inputTextField.placeholder = @"Type a task, tap Insert";
    [self readDataFromFile];
}

- (IBAction)addButton:(UIButton *)sender {
    [self.inputTextField resignFirstResponder];
    if (self.inputTextField.text.length != 0) {
        [self.listArr addObject:self.inputTextField.text];
        self.inputTextField.text = @"";
        [self.listTableView reloadData];
        [self writeDataToFile];
    }
}
    
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskListCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TaskListCell"];
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    return cell;
}

#pragma mark - DataFile
    
- (void)readDataFromFile {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:@"TaskList.plist"];
    if ([DEFAULT_FILE_MANAGER fileExistsAtPath:filePath]) {
        self.listArr = [NSMutableArray arrayWithContentsOfFile:filePath];
    } else {
        self.listArr = [[NSMutableArray alloc] init];
    }
}
    
- (void)writeDataToFile {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:@"TaskList.plist"];
    [self.listArr writeToFile:filePath atomically:YES];
}
    
@end
