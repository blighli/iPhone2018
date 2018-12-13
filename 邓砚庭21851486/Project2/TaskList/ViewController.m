//
//  ViewController.m
//  TaskList
//
//  Created by 邓砚庭 on 2018/11/1.
//  Copyright © 2018年 邓砚庭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
{
    NSMutableArray *tasks;
}
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)insertTask:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField setPlaceholder:@"input a task, tap insert"];
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }
    else {
        tasks = [[NSMutableArray alloc] init];
    }
    [self.tableView setDataSource:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertTask:(id)sender {
    NSString *text = [self.textField text];
    if ([text isEqualToString:@""]) {
        return ;
    }
    [tasks addObject:text];
    [self.tableView reloadData];
    [tasks writeToFile:docPath() atomically:YES];
    [self.textField setText:@""];
    [self.textField resignFirstResponder];
}

NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasks count];
}

@end
