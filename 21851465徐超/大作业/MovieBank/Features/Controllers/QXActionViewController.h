//
//  QXActionViewController.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QXActionViewController : UIViewController

@property (strong, nonatomic) NSArray *actionArr;               // 选项名数组
@property (assign, nonatomic) NSInteger alertActionNum;         // 警示型选项（红色显示）索引
@property (copy, nonatomic) void (^actionBlock)(NSInteger);     // 回调代码块
@property (copy, nonatomic) void (^cancelBlock)(void);          // 取消代码块

- (instancetype)initWithActionArray:(NSArray *)actionArr alertRow:(NSInteger)alertActionNum actionBlock:(void (^)(NSInteger index))actionBlock cancelBlock:(void (^ __nullable)(void))cancelBlock;

@end

NS_ASSUME_NONNULL_END
