//
//  ViewController.m
//  Memo
//
//  Created by 赵帅 on 2018/10/31.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "AddItemController.h"
#import "Item.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *barButtonAddItem;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initCoreData];
    
    self.title = @"待办事项";
    self.editButtonItem.title = @"编辑";
    self.tableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.barButtonAddItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                            target:self
                                                                            action:@selector(addNewItem:)];
    
    [self.navigationItem setLeftBarButtonItem:[self editButtonItem] animated:YES];
    [self.navigationItem setRightBarButtonItem:self.barButtonAddItem animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.editButtonItem.title = @"完成";
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    } else {
        self.editButtonItem.title = @"编辑";
        [self.navigationItem setRightBarButtonItem:self.barButtonAddItem animated:YES];
    }
    
    [self.tableView setEditing:editing animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewItem:(id)paramSender {
    
    AddItemController *addItemController = [[AddItemController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:addItemController animated:YES];
}

/**
 *  获取上下文信息
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    return managedObjectContext;
}

- (void)initCoreData {
    
    /**
     *  获取实例
     */
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:[self managedObjectContext]];
    
    NSSortDescriptor *itemNameSort = [[NSSortDescriptor alloc] initWithKey:@"itemName" ascending:YES];
    NSArray *sortDescriptors = @[itemNameSort];
    

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    fetchRequest.entity = entity;
    
    /**
     
     在CoreData为UITableView提供数据的时候，使用NSFetchedReslutsController能提高体验，
     因为用NSFetchedReslutsController去读数据的话，能最大效率的读取数据库，也方便数据变化后更新界面
     
     */
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[self managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    NSError *fetchedError = nil;
    
    if ([self.fetchedResultsController performFetch:&fetchedError]) {
        NSLog(@"Successfully fetched.");
    } else {
        NSLog(@"Failed to fetch.");
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    static NSString *itemCell = @"ItemCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:itemCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = item.itemName;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    self.fetchedResultsController.delegate = nil;
    
    [[self managedObjectContext] deleteObject:item];
    
    if ([item isDeleted]) {
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            
            NSError *fetchingError = nil;
            if ([self.fetchedResultsController performFetch:&fetchingError]) {
                
                NSLog(@"Successfully fetched");
                
                NSArray *rowsToDelete = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.tableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                
                NSLog(@"Failed to fetch with error = %@",fetchingError);
            }
        } else {
            
            NSLog(@"Failed to save the content with error = %@",savingError);
        }
    }
    
    self.fetchedResultsController.delegate = self;
}

#pragma mark - Table view delegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView reloadData];
}

@end
