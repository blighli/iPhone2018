//
//  PDDBHandler+Delete.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDDBHandler.h"

@interface PDDBHandler (Delete)

- (void)deletePhotoWithPhotoID:(NSInteger)photoID;
- (void)deleteAnswerContentWithQuestionID:(NSInteger)questionID date:(NSDate *)date;
- (void)deleteWeatherWithDate:(NSDate *)date;
- (void)deleteMoodWithDate:(NSDate *)date;

@end
