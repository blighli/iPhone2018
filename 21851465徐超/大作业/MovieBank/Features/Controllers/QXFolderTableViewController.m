//
//  QXFolderTableViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXFolderTableViewController.h"
#import "QXFolder.h"
#import "QXSeekTableViewController.h"

@interface QXFolderTableViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchVC;
@property (strong, nonatomic) NSMutableArray *searchResultsArr;

@end

@implementation QXFolderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.folder.fileName;
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressNavRightBtn)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    self.tableView.tableHeaderView = self.searchVC.searchBar;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchVC.active) {
        return self.searchResultsArr.count;
    }
    return self.folder.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MovieCell"];
    }
    QXMovie *movie;
    if (self.searchVC.active) {
        movie = self.searchResultsArr[indexPath.row];
    } else {
        movie = self.folder.movies[indexPath.row];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", movie.title, movie.year];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXMovie *movie;
    if (self.searchVC.active) {
        movie = self.searchResultsArr[indexPath.row];
    } else {
        movie = self.folder.movies[indexPath.row];
    }
    QXMovieTableViewController *movieVC = [[QXMovieTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    movieVC.movie = movie;
    movieVC.movieHasBeenSaved = YES;
    movieVC.movieNeedDownload = NO;
    movieVC.delegate = self;
    [self.navigationController pushViewController:movieVC animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要从库中删除该电影吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (self.searchVC.active) {
                QXMovie *movie = self.searchResultsArr[indexPath.row];
                [self.folder removeMovieWithID:movie.movieID];
                [self.searchResultsArr removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [self.folder removeMovieAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
        [deleteAlert addAction:cancelAction];
        [deleteAlert addAction:okAction];
        [self presentViewController:deleteAlert animated:YES completion:nil];
    }];
    return @[deleteAction];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    searchController.searchBar.showsCancelButton = YES;
    for (id c in searchController.searchBar.subviews[0].subviews) {
        if ([c isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)c;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    NSString *searchStr = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS %@", searchStr];
    self.searchResultsArr = [NSMutableArray arrayWithArray:[self.folder.movies filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
}

#pragma mark - QXMovieTableViewControllerDelegate

- (void)movieDidUpdateData:(QXMovie *)movie {
    [self.folder updateMovie:movie];
}

- (void)movieDidRemoveFromFolderWithID:(NSString *)movieID {
    [self.folder removeMovieWithID:movieID];
}

- (void)movieDidAddToFolder:(QXMovie *)movie {
    [self.folder addMovie:movie];
}

#pragma mark - EventHandlers

- (void)pressNavRightBtn {
    QXSeekTableViewController *seekVC = [[QXSeekTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:seekVC animated:YES];
}

#pragma mark - LazyLoad

- (UISearchController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchVC.searchResultsUpdater = self;
        _searchVC.dimsBackgroundDuringPresentation = NO;
        _searchVC.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        _searchVC.searchBar.placeholder = @"搜索";
        self.definesPresentationContext = YES;
    }
    return _searchVC;
}

- (NSMutableArray *)searchResultsArr {
    if (!_searchResultsArr) {
        _searchResultsArr = [[NSMutableArray alloc] init];
    }
    return _searchResultsArr;
}

@end
