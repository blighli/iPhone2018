//
//  PDPocketDiaryView.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/30.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDPocketDiaryView;

@protocol PDPocketDiaryViewDelegate <NSObject>

- (void)PocketDiaryView:(PDPocketDiaryView *)PocketDiaryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)enterEditFromCell:(UICollectionViewCell *)cell dataArrayIndex:(NSInteger)index;
- (void)enterRecordViewWithDate:(NSDate *)date;
- (void)enterInfoViewWithDate:(NSDate *)date;
- (void)enterReadViewWithDate:(NSDate *)date;

@end

@interface PDPocketDiaryView : UIView

@property (nonatomic, assign) id<PDPocketDiaryViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet UICollectionView *pieceCollectionView;
@property (nonatomic, copy) NSArray *cellDataArray;

- (void)resetPocketDiaryViewWithDate:(NSDate *)date;
- (void)setCurrentDateWithDate:(NSDate *)date;
- (void)reloadAllCell;
- (NSDate *)getCurrentDate;

@end
