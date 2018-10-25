//
//  ViewController.m
//  Project2
//
//  Created by Zhenyu Chen on 2018/10/25.
//  Copyright © 2018年 Zhenyu Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic) NSMutableArray *taskArray;

@end

@implementation ViewController {}


// Remove task
// Reference: https://developer.apple.com/documentation/uikit/uitableview?language=objc
- (IBAction)delTask:(UIButton *)sender {
    if (self.taskArray.count == 0) {
        NSLog(@"No object now!");
    }
    else {
        // Get the index of the selected row
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"Remove index : %ld, Task: %@ successfully!", indexPath.row, self.taskArray[indexPath.row]);
        // Remove object from taskArray
        [self.taskArray removeObjectAtIndex:indexPath.row];
        // Update data in TaskData.plist
        [self saveData];
        // Reload table view
        [self.tableView reloadData];
        // Hide keyboard when add new task
        [self.searchBar resignFirstResponder];
    }
}


// Add task
- (IBAction)addTask:(UIButton *)sender {
    // Check the string whether only contains whitespace.
    // Reference: https://codeday.me/bug/20170824/63501.html
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[self.searchBar.text stringByTrimmingCharactersInSet: set] length] == 0) {
        NSLog(@"String only contains whitespace or String is NULL!");
    }
    else {
        NSLog(@"Search Task: %@", self.searchBar.text);
        // Insert new task
        [self.taskArray insertObject:self.searchBar.text atIndex:self.taskArray.count];
        // Update data in TaskData.plist
        [self saveData];
        // Reload table view
        [self.tableView reloadData];
        // Hide keyboard when add new task
        [self.searchBar resignFirstResponder];
    }
}

// Load and save data
// Reference: https://stackoverflow.com/questions/23867337/how-can-i-save-retrieve-delete-update-my-data-in-plist-file-in-ios
- (void)saveData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TaskData.plist"];
    
    NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: self.taskArray, nil] forKeys:[NSArray arrayWithObjects: @"Task", nil]];
    
    NSError *error = nil;
    // Deprecated method: dataFromPropertyList:format:errorDescription:
    // Reference: https://stackoverflow.com/questions/23718903/save-data-to-plist-in-xcode
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"Data saved successfully!");
    }
    else {
        NSLog(@"Data saved failed!");
    }
}

- (void)loadData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TaskData.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSLog(@"TaskData.plist is not exist!");
    }
    else {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        self.taskArray = [dict objectForKey:@"Task"];
        NSLog(@"Loading data successfully!");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Load data from plist
    [self loadData];
    
    // Alloc memory for task array if current array does not have any object.
    if (self.taskArray.count == 0) {
        self.taskArray = [[NSMutableArray alloc] init];
    }
}

// Rewrite some necessary method
// References: https://segmentfault.com/a/1190000000380380
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *tableViewIdentifier = @"TableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taskArray count];
}

// Hide keyboard when scroll table
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}


// How to display the keyboard on the simulator?
// Reference: https://stackoverflow.com/questions/25930476/in-xcode-6-how-do-i-use-the-hardware-keyboard-but-display-the-software-keyboard
/*
1. Go to the simulator's Hardware menu.
2. Make sure Connect Hardware Keyboard is checked.
3. Choose Toggle software keyboard.
 */

@end
