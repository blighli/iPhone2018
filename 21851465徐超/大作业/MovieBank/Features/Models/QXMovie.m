//
//  QXMovie.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXMovie.h"
#import <objc/runtime.h>

#define SANDBOX_DOCUMENT_PATH       NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define SANDBOX_CACHES_PATH         NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
#define DEFAULT_FILE_MANAGER        [NSFileManager defaultManager]

@implementation QXMovie

- (instancetype)initWithMovieID:(NSString *)movieID {
    if (self = [super init]) {
        self.movieID = movieID;
    }
    return self;
}

- (instancetype)initWithJSONData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.movieID = [dic objectForKey:@"id"];
        self.title = [dic objectForKey:@"title"];
        self.titlePinyin = [self transToPinyin:self.title];
        self.year = [dic objectForKey:@"year"];
        NSDictionary *posterDic = [dic objectForKey:@"images"];
        self.poster = [posterDic objectForKey:@"large"];
        NSString *posterPath = [SANDBOX_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", self.movieID]];
        if (![DEFAULT_FILE_MANAGER fileExistsAtPath:posterPath]) {
            NSData *posterData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.poster]];
            [posterData writeToFile:posterPath atomically:YES];
        }
        NSDictionary *ratingDic = [dic objectForKey:@"rating"];
        NSNumber *ratingNum = [ratingDic objectForKey:@"average"];
        self.averageRating = [NSString stringWithFormat:@"%.1f", ratingNum.doubleValue];
        self.ratingsCount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ratings_count"]];
        self.originalTitle = [dic objectForKey:@"original_title"];
        NSArray *directorsArr = [dic objectForKey:@"directors"];
        self.directors = [[NSMutableArray alloc] init];
        for (NSDictionary *director in directorsArr) {
            [self.directors addObject:[director objectForKey:@"name"]];
        }
        NSArray *castsArr = [dic objectForKey:@"casts"];
        self.casts = [[NSMutableArray alloc] init];
        for (NSDictionary *cast in castsArr) {
            [self.casts addObject:[cast objectForKey:@"name"]];
        }
        NSArray *regionsArr = [dic objectForKey:@"countries"];
        self.regions = [[NSMutableArray alloc] initWithArray:regionsArr];
        NSArray *categoriesArr = [dic objectForKey:@"genres"];
        self.categories = [[NSMutableArray alloc] initWithArray:categoriesArr];
        self.summary = [dic objectForKey:@"summary"];
        self.mobileURI = [dic objectForKey:@"share_url"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        self.updateDate = [dateFormatter stringFromDate:[NSDate date]];
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        NSArray *properties = [self propertiesArrayOfClass:[self class]];
        for (NSString *property in properties) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *properties = [self propertiesArrayOfClass:[self class]];
    for (NSString *property in properties) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }
}

#pragma mark - Methods

- (void)updateMovieData {
    if ((self.movieID != nil) && [self.delegate conformsToProtocol:@protocol(QXMovieDataUpdateDelegate)]) {
        NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@", self.movieID];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                QXMovie *movie = [[QXMovie alloc] initWithJSONData:data];
                [self.delegate movieDataDidFinishUpdate:movie];
            } else {
                [self.delegate movieDataDidNotFinishUpdateWithError:error];
            }
        }];
        [dataTask resume];
    }
}

- (NSString *)posterFilePath {
    NSString *posterPath = [SANDBOX_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", self.movieID]];
    if (![DEFAULT_FILE_MANAGER fileExistsAtPath:posterPath]) {
        NSData *posterData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.poster]];
        [posterData writeToFile:posterPath atomically:YES];
    }
    return posterPath;
}

#pragma mark - PrivateMethods

// 动态运行时获取属性列表
- (NSArray *)propertiesArrayOfClass:(Class)class {
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:outCount];
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return propertiesArray;
}

// 将字符串中的汉字转换为拼音，以全大写形态返回
- (NSString *)transToPinyin:(NSString *)sourceStr {
    NSMutableString *source = [sourceStr mutableCopy];
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source.uppercaseString;
}

@end
