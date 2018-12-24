//
//  PDPhotoInfoCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/24.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDPhotoInfoCell : UICollectionViewCell

- (void)setupWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day photo:(UIImage *)photo;

@end
