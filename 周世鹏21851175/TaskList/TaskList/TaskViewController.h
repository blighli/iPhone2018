//
//  TaskViewController.h
//  TaskList
//
//  Created by HuaDream on 2018/10/29.
//  Copyright © 2018 HuaDream. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskViewController : UIViewController<UITableViewDataSource, UITextFieldDelegate>

- (void) saveData;
- (void) loadData;
@end

NS_ASSUME_NONNULL_END
