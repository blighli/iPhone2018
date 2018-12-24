//
//  PDGridInfoSectionData.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/26.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDGridInfoCellData.h"

@interface PDGridInfoSectionData : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, retain) NSMutableArray *cellDatas;     // 保存PDGridInfoCellData

@end
