//
//  PDDefine.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/18.
//  Copyright © 2018 赵帅. All rights reserved.
//

#ifndef PocketDiary_PDDefine_h
#define PocketDiary_PDDefine_h

#ifdef DEBUG
#define PDLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])    //会输出Log所在函数的函数名
#else
#define PDLog(...) do { } while (0)
#endif

// 颜色定义

#define MainBlueColor [UIColor colorWithRed:98 / 255.0 green:198 / 255.0 blue:248 / 255.0 alpha:1.0]

#define BackgroudGrayColor [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0]

#define TitleTextBlackColor [UIColor colorWithRed:35 / 255.0 green:35 / 255.0 blue:35 / 255.0 alpha:1.0]
#define TitleTextGrayColor [UIColor colorWithRed:191 / 255.0 green:191 / 255.0 blue:191 / 255.0 alpha:1.0]
#define ContentTextColor [UIColor colorWithRed:95 / 255.0 green:95 / 255.0 blue:95 / 255.0 alpha:1.0]


#endif
