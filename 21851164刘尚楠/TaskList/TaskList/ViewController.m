//
//  ViewController.m
//  TaskList
//
//  Created by Marveliu on 2018/10/31.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addBtn;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView setDataSource:self];
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    NSLog(@"%@",docPath());
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if(plist){
        self.tasks = [plist mutableCopy];
    }
    else {
        self.tasks = [[NSMutableArray alloc] init];
        [self.tasks addObject:@"HyperLedger"];
        [self.tasks addObject:@"Hyperchain"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString *item = [self.tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}

// add Task
- (IBAction)addBtn {
    NSString *text = [self.textField text];
    if([text isEqualToString:@""]){
        return;
    }
    [self.tasks addObject:text];
    [self.tableView reloadData];
    [self.textField setText:@""];
    [self.textField resignFirstResponder];
    [self.tasks writeToFile:docPath() atomically:YES];
}

// del Task
- (IBAction)delBtn {
    if (self.tasks.count == 0) {
        NSLog(@"No object now!");
    } else {
        // Get the index of the selected row
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        [self.textField setText:@""];
        [self.textField resignFirstResponder];
        [self.tasks writeToFile:docPath() atomically:YES];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// save data
NSString *docPath () {
    NSString *homeDir = NSHomeDirectory();
    return [homeDir stringByAppendingString:@"/data.txt"];
}

@end
