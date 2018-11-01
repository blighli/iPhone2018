//
//  ViewController.m
//  Project2
//
//  Created by 陈 洲 on 2018/10/30.
//  Copyright © 2018年 陈 洲. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic) NSMutableArray *mutableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController {}

- (void)showMsg:(NSString *)msg {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alert animated:true completion:nil];
}


- (IBAction)inserTask:(UIButton *)sender {
    
    if ([self.searchBar.text  length] == 0) {
        [self showMsg:@"输入框不能为空 ！！！"];
    }
    else {
        [self.mutableArray insertObject:self.searchBar.text atIndex:self.mutableArray.count];
        [self.mutableArray writeToFile:@"data.plist" atomically:YES];
        [self.tableView reloadData];
        [self.searchBar resignFirstResponder];
        [self showMsg:@"添加任务成功 ！！！ "];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:@"data.plist"];
    if(dataArray.count==0){
        self.mutableArray = [[NSMutableArray alloc] init];
    }else{
        self.mutableArray = [dataArray mutableCopy];
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


@end
