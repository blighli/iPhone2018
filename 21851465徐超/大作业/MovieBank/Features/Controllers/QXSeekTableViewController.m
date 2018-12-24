//
//  QXSeekTableViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXSeekTableViewController.h"
#import "QXMovieTableViewController.h"

@interface QXSeekTableViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *searchResultsArr;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) BOOL dataIsDownloading;

@end

@implementation QXSeekTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = navBackBtn;
    
    UIBarButtonItem *navLeftTextField = [[UIBarButtonItem alloc] initWithCustomView:self.textField];
    self.navigationItem.leftBarButtonItem = navLeftTextField;
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavRightBtn)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.1)];
    self.tableView.tableHeaderView = headerView;
    
    [self.textField becomeFirstResponder];
    self.dataIsDownloading = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MovieCell"];
    }
    NSArray *movie = self.searchResultsArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", movie[1], movie[2]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.dataIsDownloading == YES) {
        return @"正在下载数据，请稍候。。。";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXMovieTableViewController *movieVC = [[QXMovieTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    movieVC.movie = [[QXMovie alloc] initWithMovieID:self.searchResultsArr[indexPath.row][0]];
    movieVC.movieHasBeenSaved = NO;
    movieVC.movieNeedDownload = YES;
    movieVC.delegate = self.navigationController.viewControllers[1];
    [self.navigationController pushViewController:movieVC animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    self.dataIsDownloading = YES;
    [self.tableView reloadData];
    [self searchMovie];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.searchResultsArr removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - EventHandlers

- (void)pressNavRightBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PrivateMethods

// 按照关键字调用豆瓣搜索API，将搜索结果写入self.searchResultsArr
- (void)searchMovie {
    NSString *queryStr = [self.textField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/movie/search?q=%@", queryStr];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *movies = [dic objectForKey:@"subjects"];
            for (NSDictionary *movie in movies) {
                NSString *movieID = [movie objectForKey:@"id"];
                NSString *title = [movie objectForKey:@"title"];
                NSString *year = [movie objectForKey:@"year"];
                NSArray *movieData = @[movieID, title, year];
                [self.searchResultsArr addObject:movieData];
            }
        } else {
            UIAlertController *finishAlert = [UIAlertController alertControllerWithTitle:@"错误" message:[NSString stringWithFormat:@"搜索失败，请检查您的网络状态\n错误代码：%ld", error.code] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [finishAlert addAction:okAction];
            [self presentViewController:finishAlert animated:YES completion:nil];
        }
        self.dataIsDownloading = NO;
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
    [dataTask resume];
}

#pragma mark - LazyLoad

- (NSMutableArray *)searchResultsArr {
    if (!_searchResultsArr) {
        _searchResultsArr = [[NSMutableArray alloc] init];
    }
    return _searchResultsArr;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, 34)];
        _textField.placeholder = @"请输入关键字";
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
    }
    return _textField;
}

@end
