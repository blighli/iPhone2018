//
//  PDQuestionDetailCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/27.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDQuestionDetailCell : UITableViewCell

- (void)setupWithDay:(NSInteger)day weekday:(NSInteger)weekday answer:(NSString *)answer photo:(UIImage *)photo;

@end
