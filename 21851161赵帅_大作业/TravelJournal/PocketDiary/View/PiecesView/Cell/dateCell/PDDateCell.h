//
//  PDDateCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/30.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDDateCell : UICollectionViewCell

- (void)setupWithDate:(NSDate *)date weatherIcon:(UIImage *)weatherIcon moodIcon:(UIImage *)moodIcon;

@end
