//
//  AddItemController.m
//  Memo
//
//  Created by 赵帅 on 2018/10/31.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "AddItemController.h"
#import "AppDelegate.h"
#import "Item.h"

@interface AddItemController ()

@property (nonatomic, strong) UITextField *textFieldItemName;
@property (nonatomic, strong) UIBarButtonItem *barButtonAdd;

@end

@implementation AddItemController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新事项";
    
    CGRect textFieldRect = CGRectMake(20.0f,
                                      100.0f,
                                      self.view.bounds.size.width - 40.0f,
                                      40.0f);
    
    self.textFieldItemName = [[UITextField alloc] initWithFrame:textFieldRect];
    self.textFieldItemName.placeholder = @"添加新事项";
    self.textFieldItemName.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldItemName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textFieldItemName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.textFieldItemName];
    
    self.barButtonAdd = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(createNewItem:)];
    [self.navigationItem setRightBarButtonItem:self.barButtonAdd animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textFieldItemName becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNewItem:(id)paramSender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:managedObjectContext];
    if (item) {
        item.itemName = self.textFieldItemName.text;
        NSError *savingError = nil;
        if ([managedObjectContext save:&savingError]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Failed to save the managed object context.");
        }
    } else {
        NSLog(@"Failed to create the new item object.");
    }
}

@end
