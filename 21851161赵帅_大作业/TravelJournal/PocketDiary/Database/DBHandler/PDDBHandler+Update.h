//
//  PDDBHandler+Update.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDDBHandler.h"

@interface PDDBHandler (Update)

- (void)updateAnswerContentWith:(NSString *)text questionID:(NSInteger)questionID date:(NSDate *)date;
- (void)updateDiaryQuestionTemplateID:(NSInteger)templateID date:(NSDate *)date;
- (void)updateAnswerQuestionIDWithOldID:(NSInteger)oldID newID:(NSInteger)newID date:(NSDate *)date;
- (void)updatePhotoQuestionIDWithOldID:(NSInteger)oldID newID:(NSInteger)newID date:(NSDate *)date;
- (void)updateWeatherWithDate:(NSDate *)date weather:(NSString *)weather;
- (void)updateMoodWithDate:(NSDate *)date mood:(NSString *)mood;

@end
