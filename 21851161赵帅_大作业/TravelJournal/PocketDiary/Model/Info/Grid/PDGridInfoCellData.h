//
//  PDGridInfoCellData.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/26.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDGridInfoCellData : NSObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSMutableArray *images;

@end
