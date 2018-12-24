//
//  TableViewController.m
//  To-Do-List
//
//  Created by 汤凯凯 on 2018/10/29.
//  Copyright © 2018年 汤凯凯. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UIAlertViewDelegate>
@property(nonatomic) NSMutableArray *items;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.items = [[NSMutableArray alloc] initWithContentsOfFile:[self docPath]];
    NSLog(@"%@", self.items);
    
    self.navigationItem.title = @"TODO List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveToFile:) name:UIApplicationWillTerminateNotification object:nil];
}

#pragma mark - Save items to file
- (NSString*)docPath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    return [plistPath1 stringByAppendingPathComponent:@"data.plist"];
}

- (void)saveToFile:(NSNotification *)notification{
    [self.items writeToFile:[self docPath] atomically:YES];
}

#pragma mark - Add items

- (void) addNewItem:(UIBarButtonItem *)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New to-do item" message:@"please enter the name the new item" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"add", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        UITextField *itemNameFiled = [alertView textFieldAtIndex:0];
        NSString *itemName = itemNameFiled.text;
        NSDictionary *item = @{@"name":itemName,@"completed":@false};
        [self.items addObject:item];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *item = [self.items[indexPath.row] mutableCopy];
    item[@"completed"] = @(![item[@"completed"] boolValue]);
    
    self.items[indexPath.row] = item;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = [item[@"completed"] boolValue]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identidier = @"TODOItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identidier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *item = self.items[indexPath.row];
    
    cell.textLabel.text = item[@"name"];

    if ([item[@"completed"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
