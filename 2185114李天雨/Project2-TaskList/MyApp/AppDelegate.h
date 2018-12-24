//
//  AppDelegate.h
//  MyApp
//
//  Created by Loren on 2018/10/31.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *LTYFieldsPath(void);
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) UITableView *tableViewTask;
@property (nonatomic) UITextField *textFieldTask;
@property (nonatomic) UIButton *buttonTask;
@property (nonatomic) NSMutableArray *tasks;

- (void) addTask:(id) sender;

@end

