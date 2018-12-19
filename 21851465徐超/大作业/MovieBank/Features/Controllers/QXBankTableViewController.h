//
//  QXBankTableViewController.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QXBank;

@interface QXBankTableViewController : UITableViewController

@property (strong, nonatomic) QXBank *bank;

@end

NS_ASSUME_NONNULL_END
