//
//  Day.m
//
//  Created by xujiadai on 18/10/24.
//  Copyright © 2018年 xujiadai. All rights reserved.
//
#import "Days.h"

@implementation Days


+ (BOOL)isLeapYear:(int)year{
  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    return true;
  }
  else{
    return false;
  }
}

+ (int)daysOfUntilLastYear:(int)year{
  
  int day = 0;
  BOOL isLeap;
  for(int i = 1 ; i < year ; i++){

    isLeap = [Days isLeapYear:year];
    if(isLeap){
      day += 366;
    }
    else{
      day += 365;
    }
  }
  return day;
}

+ (int)daysOfUntilLastMonth:(int)year yue:(int)yue{
  
  NSNumber *none = [[NSNumber alloc] initWithInt:0];
  NSNumber *jan = [[NSNumber alloc] initWithInt:31];
  NSNumber *febLeap = [[NSNumber alloc] initWithInt:29];
  NSNumber *febNotLeap = [[NSNumber alloc] initWithInt:28];
  NSNumber *mar = [[NSNumber alloc] initWithInt:31];
  NSNumber *apr = [[NSNumber alloc] initWithInt:30];
  NSNumber *may = [[NSNumber alloc] initWithInt:31];
  NSNumber *jun = [[NSNumber alloc] initWithInt:30];
  NSNumber *jul = [[NSNumber alloc] initWithInt:31];
  NSNumber *aug = [[NSNumber alloc] initWithInt:31];
  NSNumber *sep = [[NSNumber alloc] initWithInt:30];
  NSNumber *oco = [[NSNumber alloc] initWithInt:31];
  NSNumber *nov = [[NSNumber alloc] initWithInt:30];
  NSNumber *dec = [[NSNumber alloc] initWithInt:31];
  
  int day = [Days daysOfUntilLastYear:year];
  NSMutableArray *monthArray = [[NSMutableArray alloc] init];
  if ([Days isLeapYear:year]) {
    NSArray *arr = [[NSArray alloc] initWithObjects:none,jan,febLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
    [monthArray addObjectsFromArray:arr];
  } else {
    NSArray *arr = [[NSArray alloc] initWithObjects:none,jan,febNotLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
    [monthArray addObjectsFromArray:arr];
  }
  for(int i = 1 ; i < yue ; i++){
    day += [[monthArray objectAtIndex:i] intValue];
  }
  return day;
}

@end
