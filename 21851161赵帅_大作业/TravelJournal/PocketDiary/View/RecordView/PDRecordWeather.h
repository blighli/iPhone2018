//
//  PDRecordWeather.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDRecordSetting.h"

typedef NS_ENUM(NSInteger, WeatherRecord){
    WeatherRecordSun = 1,   // 晴
    WeatherRecordCloud,     // 阴
    WeatherRecordWind,      // 风
    WeatherRecordDrizzle,   // 小雨
    WeatherRecordRain,      // 大雨
    WeatherRecordLightning, // 闪电
    WeatherRecordSnow,      // 雪
    WeatherRecordFog        // 雾
};


@interface PDRecordWeather : PDRecordSetting

+ (NSString *)getWeatherStrWithRecordType:(WeatherRecord)weather;
+ (WeatherRecord)getWeatherRecordWithString:(NSString *)string;

+ (UIImage *)getWeatherImageWithWeatherString:(NSString *)weatherString;
+ (UIImage *)getMoodDefaultImage;

@end
