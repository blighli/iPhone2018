//
//  PDDBHandler+Insert.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import "PDDBHandler.h"

@interface PDDBHandler (Insert)

- (void)insertAnswerContentWith:(NSString *)text questionID:(NSInteger)questionID date:(NSDate *)date;
- (void)insertQuestionContentWithText:(NSString *)text;
- (void)insertQuestionTemplateWithQuestionIDs:(NSArray *)questionIDs;
- (void)insertDiaryDate:(NSDate *)date questionTemplateID:(NSInteger)templateID;
- (void)insertPhotoData:(NSData *)photoData inDate:(NSDate *)date questionID:(NSInteger)questionID;
- (void)insertWeather:(NSString *)weather inDate:(NSDate *)date;
- (void)insertMood:(NSString *)mood inDate:(NSDate *)date;

@end
