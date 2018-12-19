//
//  ViewController.m
//  tasklist
//
//  Created by ding on 2018/10/29.
//  Copyright © 2018年 ding. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) saveData: (NSNotification* ) notification
{
    NSString* path=[self getFilePath];
    [self.tasks writeToFile:path atomically:YES];
}
- (NSString *) getFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* filePath=[paths[0] stringByAppendingPathComponent:@"tasklist.plist"];
    return filePath;
}
- (IBAction)addTask:(UIButton *)sender {
    if([self.taskTextField.text isEqualToString:@""]){

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No task typed!" message:@"Please type task and tap insert." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController: alert animated: YES completion: nil];
    }else{
        [self.tasks addObject:self.taskTextField.text];
        self.taskTextField.text = @"";
        [self.taskTableView reloadData];
        [self.taskTextField resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *list=[NSArray arrayWithContentsOfFile: [self getFilePath]];
    if(list){
        self.tasks = [list mutableCopy];
    }else{
        self.tasks=[[NSMutableArray alloc]init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"myTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)textFiledDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];
}


@end
