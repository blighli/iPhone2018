//
//  Block.h
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BlockTypeStart = 1,
    BlockTypeEnd = 2,
    BlockTypeBlack = 3,
    BlockTypeWhite = 4
}BlockType;

@interface Block : UIButton
/**
 *  方块的类型
 */
@property (nonatomic, assign) BlockType type;

/**
 *  方块所在第几行
 */
@property (nonatomic, assign) NSInteger line;

/**
 *  是否生成了下一个
 */
@property (nonatomic, assign) BOOL user;

@property (nonatomic, assign) NSInteger index;

@end
