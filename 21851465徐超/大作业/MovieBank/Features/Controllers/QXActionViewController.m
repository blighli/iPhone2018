//
//  QXActionViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXActionViewController.h"

#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define ROW_HEIGHT                  50
#define TABLEVIEW_HEADER_HEIGHT     0.01
#define TABLEVIEW_FOOTER_HEIGHT     2.99

@interface QXActionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation QXActionViewController

- (instancetype)initWithActionArray:(NSArray *)actionArr alertRow:(NSInteger)alertActionNum actionBlock:(void (^)(NSInteger index))actionBlock cancelBlock:(void (^ __nullable)(void))cancelBlock {
    if (self = [super init]) {
        self.actionArr = actionArr;
        self.alertActionNum = alertActionNum;
        self.actionBlock = actionBlock;
        self.cancelBlock = cancelBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self showView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.actionArr.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActionCell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.actionArr[indexPath.row];
        if (indexPath.row == self.alertActionNum) {
            cell.textLabel.textColor = [UIColor redColor];
        }
    } else {
        cell.textLabel.text = @"取消";
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        self.actionBlock(indexPath.row);
    }
    [self dismissView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TABLEVIEW_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TABLEVIEW_FOOTER_HEIGHT;
}

#pragma  mark - UIResponder

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissView];
}

#pragma mark - PrivateMethods

- (void)showView {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.1;
        CGRect rect = self.tableView.frame;
        rect.origin.y -= self.tableView.frame.size.height;
        self.tableView.frame = rect;
    }];
}

- (void)dismissView {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        CGRect rect = self.tableView.frame;
        rect.origin.y += self.tableView.frame.size.height;
        self.tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - LazyLoad

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ROW_HEIGHT * (self.actionArr.count + 1) + TABLEVIEW_HEADER_HEIGHT + TABLEVIEW_FOOTER_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
        _tableView.rowHeight = ROW_HEIGHT;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end
