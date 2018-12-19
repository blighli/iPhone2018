//
//  QXFolderTableViewController.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QXMovieTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class QXFolder;

@interface QXFolderTableViewController : UITableViewController <QXMovieTableViewControllerDelegate>

@property (strong, nonatomic) QXFolder *folder;

@end

NS_ASSUME_NONNULL_END
