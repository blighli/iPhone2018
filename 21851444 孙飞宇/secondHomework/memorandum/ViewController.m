//
//  ViewController.m
//  memorandum
//
//  Created by AmoWho Vos on 2018/10/28.
//  Copyright © 2018 AmoWho Vos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
{
    NSMutableArray *tasks;
}
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
        tasks = [plist mutableCopy];
    }
    else {
        tasks = [[NSMutableArray alloc] init];
        [tasks addObject:@"Java"];
        [tasks addObject:@"Go"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}

// 处理按钮的事件
- (IBAction)addBtn {
    NSString *text = [self.textField text];
    if([text isEqualToString:@""]){
        return;
    }
    [tasks addObject:text];
    [self.tableView reloadData];
    [self.textField setText:@""];
    [self.textField resignFirstResponder];
    [tasks writeToFile:docPath() atomically:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// 文件保存路径
NSString *docPath () {
    NSString *homeDir = NSHomeDirectory();
    return [homeDir stringByAppendingString:@"/data.txt"];
}

@end
