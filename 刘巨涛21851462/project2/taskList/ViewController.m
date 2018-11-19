//
//  ViewController.m
//  taskList
//
//  Created by Jutao on 2018/11/2.
//  Copyright © 2018 Jutao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic) NSMutableArray *mutableArray;

@end

@implementation ViewController{}


- (void)saveTask {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Task.plist"];
    
    NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: self.mutableArray, nil] forKeys:[NSArray arrayWithObjects: @"task", nil]];
    
    NSError *error = nil;

    NSData *plistTask = [NSPropertyListSerialization dataWithPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if(plistTask) {
        [plistTask writeToFile:plistPath atomically:YES];
        NSLog(@"任务保存成功！");
    }
    else {
        NSLog(@"任务保存失败！");
    }
}

//加载任务
- (void)loadTask {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Task.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSLog(@"plist不存在！");
    }
    else {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        self.mutableArray = [dict objectForKey:@"task"];
        NSLog(@"载入成功！");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTask];
    
    if (self.mutableArray.count == 0) {
        self.mutableArray = [[NSMutableArray alloc] init];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *tableViewIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    cell.textLabel.text = [self.mutableArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mutableArray count];
}

//添加新任务
- (IBAction)insertTask:(UIButton *)sender {

    [self.mutableArray insertObject:self.searchBar.text atIndex:self.mutableArray.count];//加入新任务
    [self saveTask];
    [self.tableView reloadData];  //重新加载tableView
    
}

@end

