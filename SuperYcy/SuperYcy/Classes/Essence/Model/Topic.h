//
//  Topic.h
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/12/04.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TopicType) {
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41
};
@interface Topic : NSObject
//Cell顶部标签
//用户名
@property (nonatomic, copy) NSString *name;
//用户头像
@property (nonatomic, copy) NSString *profile_image;
//内容
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *passtime;

//Cell底部标签
//顶数量
@property (nonatomic, assign) NSInteger ding;
//踩数量
@property (nonatomic, assign) NSInteger cai;
//转发、分享数量
@property (nonatomic, assign) NSInteger repost;
//评论数量
@property (nonatomic, assign) NSInteger comment;
/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
