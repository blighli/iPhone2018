//
//  PDPieceCellData.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/25.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDPhotoData;

@interface PDPieceCellData : NSObject

// 日记界面每个cell包含的数据
@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSArray<PDPhotoData *> *photoDatas;

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, assign) NSInteger questionID;

@end
