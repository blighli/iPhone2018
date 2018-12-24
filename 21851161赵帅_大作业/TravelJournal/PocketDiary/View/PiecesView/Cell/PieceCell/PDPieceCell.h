//
//  PDPieceCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDPieceCell : UICollectionViewCell

- (void)setupWithQuestion:(NSString *)question answer:(NSString *)answer photos:(NSArray<UIImage *> *)photos;

@end
