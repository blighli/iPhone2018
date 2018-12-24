//
//  QXBankTableViewController.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXBankTableViewController.h"
#import "QXBank.h"
#import "QXFolder.h"
#import "QXFolderTableViewController.h"

@implementation QXBankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.bank.fileName;
    
    UIBarButtonItem *navLeftBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavLeftBtn)];
    self.navigationItem.leftBarButtonItem = navLeftBtn;
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressNavRightBtn)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.1)];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bank.folders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FolderCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FolderCell"];
    }
    cell.textLabel.text = self.bank.folders[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing == NO) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        QXFolderTableViewController *folderVC = [[QXFolderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        folderVC.folder = [[QXFolder alloc] initWithFileName:self.bank.folders[indexPath.row]];
        [self.navigationController pushViewController:folderVC animated:YES];
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要删除该电影库吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.bank removeFolderAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [deleteAlert addAction:cancelAction];
        [deleteAlert addAction:okAction];
        [self presentViewController:deleteAlert animated:YES completion:nil];
    }];
    
    UITableViewRowAction *renameAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"重命名" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *renameAlert = [UIAlertController alertControllerWithTitle:@"重命名" message:@"重命名电影库文件夹" preferredStyle:UIAlertControllerStyleAlert];
        [renameAlert addTextFieldWithConfigurationHandler: nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            BOOL finished = [self.bank renameFolderAtIndex:indexPath.row withNewTitle:renameAlert.textFields[0].text];
            if (finished) {
                [self.tableView reloadData];
            } else {
                UIAlertController *sameAlert = [UIAlertController alertControllerWithTitle:@"冲突" message:@"文件夹的新名字与已有文件夹重名\n操作取消" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
                [sameAlert addAction:okAction];
                [self presentViewController:sameAlert animated:YES completion:nil];
            }
        }];
        [renameAlert addAction:cancelAction];
        [renameAlert addAction:okAction];
        [self presentViewController:renameAlert animated:YES completion:nil];
    }];
    
    return @[deleteAction, renameAction];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.bank moveFolderAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - EventHandlers

- (void)pressNavLeftBtn {
    [self.tableView setEditing:YES animated:YES];
    UIBarButtonItem *navLeftBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavLeftBtnAgain)];
    self.navigationItem.leftBarButtonItem = navLeftBtn;
}

- (void)pressNavLeftBtnAgain {
    [self.tableView setEditing:NO animated:YES];
    UIBarButtonItem *navLeftBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pressNavLeftBtn)];
    self.navigationItem.leftBarButtonItem = navLeftBtn;
}

- (void)pressNavRightBtn {
    UIAlertController *addAlert = [UIAlertController alertControllerWithTitle:@"新建文件夹" message:@"创建一个新电影库文件夹" preferredStyle:UIAlertControllerStyleAlert];
    [addAlert addTextFieldWithConfigurationHandler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BOOL finished = [self.bank addFolderWithTitle:addAlert.textFields[0].text];
        if (finished) {
            [self.tableView reloadData];
        } else {
            UIAlertController *sameAlert = [UIAlertController alertControllerWithTitle:@"冲突" message:@"新文件夹与已有文件夹重名\n创建失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [sameAlert addAction:okAction];
            [self presentViewController:sameAlert animated:YES completion:nil];
        }
    }];
    [addAlert addAction:cancelAction];
    [addAlert addAction:okAction];
    [self presentViewController:addAlert animated:YES completion:nil];
}

@end
