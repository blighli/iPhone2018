//
//  TimiItemCollectionViewCell.h
//  Timi
//
//
//  Created by abby on 18/12/11.
//

#import <UIKit/UIKit.h>

@interface TimiItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *cellImage;
@property (nonatomic, strong) UILabel *cellLabel;

@property (nonatomic, strong) UIImageView *cellPic;



+ (instancetype)createCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier;

@end
