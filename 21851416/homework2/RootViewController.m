//
//  RootViewController.m
//  iostest02
//
//  Created by 贺晨韬 on 2018/10/31.
//  Copyright © 2018 贺晨韬. All rights reserved.
//

#import "RootViewController.h"
#import <sqlite3.h>
#import "Model.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
    name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
    name:UIApplicationDidBecomeActiveNotification object:nil];
    AddedNewItem = [[NSMutableArray alloc] init];
    
    databaseconn = [[DateOperateController alloc]init];
    [databaseconn openSqlite];
    
    NSArr = [databaseconn selectWithAll];
    [databaseconn closeSqlite];
    
//    NSArr = [[NSMutableArray alloc] initWithObjects:@"data 1", @"data 2", @"data 3", @"data 4", @"data 5", @"data 6", @"data 7", @"data 8", @"data 9",@"data 10", @"data 11", @"data 12", @"data 13", @"data 14", @"data 15",nil];
    
    
    searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar sizeToFit];
    
    
    tbview = [[UITableView alloc] init];
    tbview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    tbview.dataSource = self;
    tbview.tableHeaderView = searchBar;
    [self.view addSubview:tbview];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    int i;
    DateOperateController *tempDataConn = [[DateOperateController alloc] init];
    [tempDataConn openSqlite];
    for (i=0; i<[AddedNewItem count]; i++){
        NSString *itname = [AddedNewItem objectAtIndex:i];
//        NSLog(@"%@ %d", itname,i);
        NSListItem *additem = [[NSListItem alloc]initWithItem:0 itemName:itname];
        [tempDataConn addItem:additem];
    }
    
    [tempDataConn closeSqlite];
    NSLog(@"触发home按下");
}
- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    NSLog(@"重新进来后响应");
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSInteger count;
    if (tableView == searchDisplayController.searchResultsTableView) {
        NSString *searchText = searchBar.text;
//        NSLog(@"%@",searchText);
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchText];
        searchresultarr = [NSArr filteredArrayUsingPredicate:resultPredicate];
        count = searchresultarr.count;
    }
    else{
        count = NSArr.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor blackColor];
    }
//    NSListItem *nsli;
    NSString *nsli;
    
    
    if(tableView == searchDisplayController.searchResultsTableView)
    {
        nsli = [searchresultarr objectAtIndex:indexPath.row];
    }
    else{
        nsli = [NSArr objectAtIndex:indexPath.row];
    }
    
//    NSLog(@"%@  %ld",nsli,indexPath.row);
    cell.textLabel.text = nsli;
//    cell.textLabel.text = @"Hello";
    // Configure the cell...
    
    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    [tbview reloadData];
    NSLog(@"begin");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
//    [tbview reloadData];
    NSString *NewItem = [[NSString alloc]initWithString:searchBar.text];
    [AddedNewItem addObject:NewItem];
    [NSArr addObject:NewItem];

    NSLog(@"end");
    return  YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    NSLog(@"change");
    
}

- (void)viewDidDisappear:(BOOL)animated{
    int i;
    [databaseconn openSqlite];
    for (i=0; i<[AddedNewItem count]; i++){
        NSString *itname = [AddedNewItem objectAtIndex:i];
        NSListItem *additem = [[NSListItem alloc]initWithItem:0 itemName:itname];
        [databaseconn addItem:additem];
    }
    [databaseconn closeSqlite];
}


 -(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
 {
     [self filterContentForSearchText:searchString scope:[[searchDisplayController.searchBar scopeButtonTitles]  objectAtIndex:[searchDisplayController.searchBar selectedScopeButtonIndex]]];
 
     return(YES);
 }

 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
 {
     [self filterContentForSearchText:[searchDisplayController.searchBar text] scope:[[searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
     
     return(YES);
 }
 
 - (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
 
//     NSLog(@"Pro come in");
     NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchText];
     searchresultarr = [NSArr filteredArrayUsingPredicate:resultPredicate];
 }


//- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
//
//    [searchBar resignFirstResponder];
//}
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}



@end
