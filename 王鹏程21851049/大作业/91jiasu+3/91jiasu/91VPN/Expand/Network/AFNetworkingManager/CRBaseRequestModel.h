//
//  CRBaseRequestModel.h
//  GoPanda
//
//  Created by Lee on 15/8/1.
//  Copyright (c) 2015年 jiangyong. All rights reserved.
//

#import "JSONModel.h"

@interface CRBaseRequestHeaderModel : JSONModel
@property (nonatomic, strong) NSString *submitTime;
@property (nonatomic, strong) NSString *sign;
@end

@interface CRBaseRequestModel : JSONModel
@property (nonatomic, strong) CRBaseRequestHeaderModel *header;
@end

