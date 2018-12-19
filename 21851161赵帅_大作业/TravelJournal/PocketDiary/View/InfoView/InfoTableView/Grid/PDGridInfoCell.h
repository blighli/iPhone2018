//
//  PDGridInfoCell.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/22.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDGridInfoCell : UITableViewCell

- (void)setupWithDay:(NSInteger)day weekday:(NSInteger)weekday question:(NSString *)question answer:(NSString *)answer photo:(UIImage *)photo;

@end
