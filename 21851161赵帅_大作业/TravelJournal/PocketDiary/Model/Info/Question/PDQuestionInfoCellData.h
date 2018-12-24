//
//  PDQuestionInfoCellData.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/26.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDQuestionInfoCellData : NSObject

@property (nonatomic, retain) NSString *questionContent;
@property (nonatomic, assign) NSInteger quatity;
@property (nonatomic, retain) NSMutableArray *sectionDataArray;    // 保存PDGridInfoSectionData对象

@end
