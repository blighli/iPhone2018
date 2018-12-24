//
//  PDGridCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PDGridCellType)
{
    PDGridCellTypeDiary = 0,    // 旅行
    PDGridCellTypeCrid,         // 记录
    PDGridCellTypeQuestion,     // 问题
    PDGridCellTypePhoto         // 图片
};

@interface PDGridCell : UICollectionViewCell

@property (nonatomic, assign) PDGridCellType type;

- (void)setCellTitleWithText:(NSString *)text;
- (void)setQuantityWithNumber:(NSInteger)number;

@end
