//
//  QXMovieTableViewController.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QXMovie.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QXMovieTableViewControllerDelegate <NSObject>

- (void)movieDidUpdateData:(QXMovie *)movie;
- (void)movieDidRemoveFromFolderWithID:(NSString *)movieID;
- (void)movieDidAddToFolder:(QXMovie *)movie;

@end

@interface QXMovieTableViewController : UITableViewController <QXMovieDataUpdateDelegate>

@property (strong, nonatomic) QXMovie *movie;
@property (assign, nonatomic) BOOL movieHasBeenSaved;
@property (assign ,nonatomic) BOOL movieNeedDownload;

@property (weak, nonatomic) id<QXMovieTableViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
