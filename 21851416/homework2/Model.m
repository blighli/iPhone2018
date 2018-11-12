//
//  Model.m
//  iostest02
//
//  Created by 贺晨韬 on 2018/10/31.
//  Copyright © 2018 贺晨韬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@implementation NSListItem
- (instancetype)initWithItem:(NSInteger*)itemId itemName:(NSString*)itemName {
    self = [super init];
//    NSLog(@"%d %@",itemId,itemName);
    if (self) {
        _itemId = itemId;
        _itemName = itemName;
    }
    return self;
}

- (instancetype) init {
    return [self initWithItem:nil itemName:nil];
}
@end
