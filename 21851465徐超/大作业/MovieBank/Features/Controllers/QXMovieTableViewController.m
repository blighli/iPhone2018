//
//  QXMovieTableViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXMovieTableViewController.h"
#import "QXMoviePosterTableViewCell.h"
#import "QXMovieDetailTableViewCell.h"
#import "QXActionViewController.h"
#import "QXWebViewController.h"

@implementation QXMovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"电影信息 豆瓣ID:%@", self.movie.movieID];
    
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = navBackBtn;
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressNavRightBtn)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.1)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    if (self.movieNeedDownload == YES) {
        self.movie.delegate = self;
        [self.movie updateMovieData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movieNeedDownload == YES) {
        return 0;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QXMoviePosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviePosterCell"];
        if (!cell) {
            cell = [[QXMoviePosterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoviePosterCell"];
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)", self.movie.title, self.movie.year];
        cell.posterImageView.image = [UIImage imageWithContentsOfFile:[self.movie posterFilePath]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        QXMovieDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieDetailCell"];
        if (!cell) {
            cell = [[QXMovieDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieDetailCell"];
        }
        switch (indexPath.row) {
            case 1:
                cell.titleLabel.text = @"评分";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@ (共 %@ 人打分)", self.movie.averageRating, self.movie.ratingsCount];
                break;
            case 2:
                cell.titleLabel.text = @"原名";
                cell.contentLabel.text = self.movie.originalTitle;
                break;
            case 3:
                cell.titleLabel.text = @"导演";
                cell.contentLabel.text = [self.movie.directors componentsJoinedByString:@"、"];
                break;
            case 4:
                cell.titleLabel.text = @"主演";
                cell.contentLabel.text = [self.movie.casts componentsJoinedByString:@"、"];
                break;
            case 5:
                cell.titleLabel.text = @"产地";
                cell.contentLabel.text = [self.movie.regions componentsJoinedByString:@"、"];
                break;
            case 6:
                cell.titleLabel.text = @"类型";
                cell.contentLabel.text = [self.movie.categories componentsJoinedByString:@"、"];
                break;
            case 7:
                cell.titleLabel.text = @"简介";
                cell.contentLabel.text = self.movie.summary;
                break;
            default:
                break;
        }
        if ((cell.contentLabel.text == nil) || [cell.contentLabel.text isEqualToString:@""]) {
            cell.contentLabel.text = @"-";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.movieNeedDownload == YES) {
        return @"正在下载数据，请稍候。。。";
    }
    return [NSString stringWithFormat:@"数据更新时间：%@", self.movie.updateDate];
}

#pragma mark - QXMovieDataUpdateDelegate

- (void)movieDataDidFinishUpdate:(QXMovie *)movie {
    self.movie = movie;
    if (self.movieNeedDownload == YES) {
        self.movieNeedDownload = NO;
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    } else {
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        if (self.movieHasBeenSaved == YES) {
            [self.delegate movieDidUpdateData:self.movie];
        }
        UIAlertController *finishAlert = [UIAlertController alertControllerWithTitle:@"完成" message:@"数据更新成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [finishAlert addAction:okAction];
        [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:finishAlert animated:YES completion:nil];
    }
}

- (void)movieDataDidNotFinishUpdateWithError:(NSError *)error {
    self.movie.delegate = nil;
    UIAlertController *finishAlert = [UIAlertController alertControllerWithTitle:@"错误" message:[NSString stringWithFormat:@"数据更新失败，请检查您的网络状态\n错误代码：%ld", error.code] preferredStyle:UIAlertControllerStyleAlert];
    if (self.movieNeedDownload == YES) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [finishAlert addAction:okAction];
    } else {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [finishAlert addAction:okAction];
        [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    [self presentViewController:finishAlert animated:YES completion:nil];
}

#pragma mark - EventHandlers

- (void)pressNavRightBtn {
    if (self.movieNeedDownload == NO) {
        QXActionViewController *actionVC;
        if (self.movieHasBeenSaved == YES) {
            actionVC = [[QXActionViewController alloc] initWithActionArray:@[@"更新数据", @"访问知乎专题页", @"从库中删除"] alertRow:2 actionBlock:^(NSInteger index) {
                if (index == 0) {
                    self.movie.delegate = self;
                    [self.movie updateMovieData];
                } else if (index == 1) {
                    QXWebViewController *webVC = [[QXWebViewController alloc] initWithURL:self.movie.mobileURI];
                    [self.navigationController pushViewController:webVC animated:YES];
                } else if (index == 2) {
                    UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"删除" message:@"确定要从库中删除该电影吗？" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        [self.delegate movieDidRemoveFromFolderWithID:self.movie.movieID];
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [deleteAlert addAction:cancelAction];
                    [deleteAlert addAction:okAction];
                    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
                    [self presentViewController:deleteAlert animated:YES completion:nil];
                }
            } cancelBlock:nil];
        } else {
            actionVC = [[QXActionViewController alloc] initWithActionArray:@[@"添加到库中", @"访问知乎专题页"] alertRow:-1 actionBlock:^(NSInteger index) {
                if (index == 0) {
                    [self.delegate movieDidAddToFolder:self.movie];
                    self.movieHasBeenSaved = YES;
                    UIAlertController *addAlert = [UIAlertController alertControllerWithTitle:@"完成" message:@"电影已添加到库中" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
                    [addAlert addAction:okAction];
                    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
                    [self presentViewController:addAlert animated:YES completion:nil];
                } else if (index == 1) {
                    QXWebViewController *webVC = [[QXWebViewController alloc] initWithURL:self.movie.mobileURI];
                    [self.navigationController pushViewController:webVC animated:YES];
                }
            } cancelBlock:nil];
        }
        actionVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:actionVC animated:NO completion:nil];
    }
}

@end
