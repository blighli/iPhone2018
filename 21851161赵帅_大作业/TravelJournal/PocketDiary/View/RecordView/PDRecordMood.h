//
//  PDRecordMood.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDRecordSetting.h"

typedef NS_ENUM(NSInteger, MoodRecord){
    MoodRecordHappy = 1,    // 高兴
    MoodRecordNeutral,      // 平淡
    MoodRecordVeryHappy,    // 非常高兴
    MoodRecordCool,         // 酷
    MoodRecordUnhappy,      // 不高兴
    MoodRecordWondering,    // 疑惑
    MoodRecordSad,          // 悲伤
    MoodRecordAngry         // 生气
};

@interface PDRecordMood : PDRecordSetting

+ (NSString *)getMoodStringWithRecordType:(MoodRecord)mood;
+ (MoodRecord)getMoodRecordWithString:(NSString *)string;

+ (UIImage *)getMoodImageWithMoodString:(NSString *)moodString;
+ (UIImage *)getMoodDefaultImage;

@end
