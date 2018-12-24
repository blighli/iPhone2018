//
//  ChatModel.h
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPManager.h"

@interface ChatModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;


- (void)populateRandomDataSource;

/**
 *  获取历史消息
 *
 *  @param jid 对方jid
 */
-(void) getMessageHistoryWithJID:(XMPPJID*)jid;

- (void)addRandomItemsToDataSource:(NSInteger)number;

- (void)addSpecifiedItem:(NSDictionary *)dic;

@end
