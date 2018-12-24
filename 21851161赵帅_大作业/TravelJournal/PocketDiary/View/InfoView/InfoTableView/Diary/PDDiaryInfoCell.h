//
//  PDDiaryInfoCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/22.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDDiaryInfoCell : UITableViewCell

- (void)setupWithDay:(NSInteger)day weekday:(NSInteger)weekday weatherImage:(UIImage *)weatherImage moodImage:(UIImage *)moodImage;

@end
