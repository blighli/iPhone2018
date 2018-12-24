//
//  NearbyPhotoCollectionViewController.h
//  游园
//
//  Created by Ray on 15/12/9.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowPhotoViewController.h"

@interface NearbyPhotoCollectionViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)NSMutableArray *photos;

@end
