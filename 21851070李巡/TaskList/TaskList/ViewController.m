//
//  ViewController.m
//  TaskList
//
//  Created by 之川 on 2018/10/27.
//  Copyright © 2018 LX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//data
@property (strong,nonatomic) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.data = [[NSMutableArray alloc]init];
}

//insert
- (IBAction)add:(id)sender {
    if(self.taskInput.text.length > 0){
        [self.data addObject:self.taskInput.text];
        NSLog(@"%@", self.data);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
        [self.taskList insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.taskInput setText:@""];
    }
}

//tableview cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *text = [self.data[indexPath.row] description];
    cell.textLabel.text = text;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

//can delete items
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
@end
