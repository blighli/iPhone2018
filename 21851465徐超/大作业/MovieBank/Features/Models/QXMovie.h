//
//  QXMovie.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class QXMovie;

@protocol QXMovieDataUpdateDelegate <NSObject>

- (void)movieDataDidFinishUpdate:(QXMovie *)movie;
- (void)movieDataDidNotFinishUpdateWithError:(NSError *)error;

@end

@interface QXMovie : NSObject <NSCoding>

@property (copy, nonatomic) NSString *movieID;              // 豆瓣电影ID
@property (copy, nonatomic) NSString *title;                // 电影标题
@property (copy, nonatomic) NSString *titlePinyin;          // 标题拼音
@property (copy, nonatomic) NSString *year;                 // 年份
@property (copy, nonatomic) NSString *poster;               // 海报网址链接
@property (copy, nonatomic) NSString *averageRating;        // 评分
@property (copy, nonatomic) NSString *ratingsCount;         // 评分人数
@property (copy, nonatomic) NSString *originalTitle;        // 原始标题
@property (strong, nonatomic) NSMutableArray *directors;    // 导演
@property (strong, nonatomic) NSMutableArray *casts;        // 主演
@property (strong, nonatomic) NSMutableArray *regions;      // 产地
@property (strong, nonatomic) NSMutableArray *categories;   // 类型
@property (copy, nonatomic) NSString *summary;              // 简介
@property (copy, nonatomic) NSString *mobileURI;            // 网页链接
@property (copy, nonatomic) NSString *updateDate;           // 数据更新时间

@property (weak, nonatomic) id<QXMovieDataUpdateDelegate> delegate;

- (instancetype)initWithMovieID:(NSString *)movieID;

- (void)updateMovieData;

- (NSString *)posterFilePath;

@end

NS_ASSUME_NONNULL_END
