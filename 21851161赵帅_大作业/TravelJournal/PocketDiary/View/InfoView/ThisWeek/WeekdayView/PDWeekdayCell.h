//
//  PDWeekdayCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/19.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , PDWeekdayCellState)
{
    PDWeekdayCellStateNoDiary = 1,     // 没有日记内容
    PDWeekdayCellStateHasDiary,        // 有日记内容
    PDWeekdayCellStateCurrentDay       // 本周当天
};

@interface PDWeekdayCell : UICollectionViewCell

- (void)setupWithWeekday:(NSString *)weekday day:(NSString *)day state:(PDWeekdayCellState)state;

@end
