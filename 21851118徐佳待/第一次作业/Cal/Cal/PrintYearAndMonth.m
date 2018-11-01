//
//  PrintYearAndMonth.m
//  Cal
//
//  Created by xujiadai on 18/10/24.
//  Copyright © 2018年 xujiadai. All rights reserved.
//

#import "PrintYearAndMonth.h"
#import "Days.h"

@implementation PrintYearAndMonth

- (void) printmonth:(int)year yue:(int)yue{
  
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
  
  NSMutableArray *monthArray = [[NSMutableArray alloc] init];
  
  if ([Days isLeapYear:year]) {

    NSArray *arr = [[NSArray alloc] initWithObjects:none,jan,febLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
    [monthArray addObjectsFromArray:arr];
  } else {

    NSArray *arr = [[NSArray alloc] initWithObjects:none,jan,febNotLeap,mar,apr,may,jun,jul,aug,sep,oco,nov,dec, nil];
    [monthArray addObjectsFromArray:arr];
  }
  int day=0;

  NSString *calendarStr = [[NSString alloc] initWithFormat:@"%@",@" Su Mo Tu We Th Fr Sa"];
  NSMutableString *yearStr = [[NSMutableString alloc] initWithFormat:@"%d",year];
  NSMutableString *monthStr = [PrintYearAndMonth transformMonthToEnglish:yue];
  [monthStr appendString:@" "];
  [monthStr appendString:yearStr];
  int titleLen = (int)yearStr.length;
  int calendarLen = (int)calendarStr.length;
  int blankLen = (calendarLen - titleLen) / 2;
  for (int i = 0; i < blankLen - 2; i++) {
    printf(" ");
  }
  printf("%s\n",[monthStr UTF8String]);
  printf(" Su Mo Tu We Th Fr Sa\n");
  day = [Days daysOfUntilLastMonth:year yue:yue];
  
    
  int position = (day + 5) % 7 + 1;
  if (position == 7) {
  }else{
    for (int i = 0; i < position; i++) {
      printf("   ");
    }
  }
  int i;
  for (i = 0; i < (6 - position) + 1;) {
    printf(" %2d",++i);
  }
  if (position == 7) {
  } else {
    printf("\n");
  }
  int count = 0;
  for (; i < [[monthArray objectAtIndex:yue] intValue]; ) {
    
    printf(" %2d",++i);
    count++;
    if (count == 7) {
      printf("\n");
      count = 0;
    }
  }
  printf("\n");
}
+ (NSMutableString *) transformMonthToEnglish:(int)month{
  switch (month) {
    case  1:
      return [[NSMutableString alloc] initWithFormat:@"January"];
      break;
    case  2:
      return [[NSMutableString alloc] initWithFormat:@"February"];
      break;
    case  3:
      return [[NSMutableString alloc] initWithFormat:@"March"];
      break;
    case  4:
      return [[NSMutableString alloc] initWithFormat:@"April"];
      break;
    case  5:
      return [[NSMutableString alloc] initWithFormat:@"May"];
      break;
    case  6:
      return [[NSMutableString alloc] initWithFormat:@"June"];
      break;
    case  7:
      return [[NSMutableString alloc] initWithFormat:@"July"];
      break;
    case  8:
      return [[NSMutableString alloc] initWithFormat:@"August"];
      break;
    case  9:
      return [[NSMutableString alloc] initWithFormat:@"September"];
      break;
    case  10:
      return [[NSMutableString alloc] initWithFormat:@"October"];
      break;
    case  11:
      return [[NSMutableString alloc] initWithFormat:@"November"];
      break;
    case  12:
      return [[NSMutableString alloc] initWithFormat:@"December"];
      break;
    default:
      break;
  }
  return [[NSMutableString alloc] initWithFormat:@""];;
}

- (void) printyear:(int)year{

  printf("                               %d\n\n",year);

  printf("       January               February               March\n");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf("\n");
  int day1 = 0;

  day1 = [Days daysOfUntilLastMonth:year yue:1];
  int position1 = (day1 + 5) % 7 + 1;
  if (position1 == 7) {
  }else{
    for (int i = 0; i < position1; i++) {
      printf("   ");
    }
  }
  int i1;
  if (position1 == 7) {
    for (i1 = 0; i1 < 7;) {
      printf(" %2d",++i1);
    }
  } else {
    for (i1 = 0; i1 < (6 - position1) + 1;) {
      printf(" %2d",++i1);
    }
  }

  int day2 = 0;
  day2 = [Days daysOfUntilLastMonth:year yue:2];
  int position2 = (day2 + 5) % 7 + 1;
  
  printf(" ");
  if (position2 == 7) {
  }else{
    for (int i = 0; i < position2; i++) {
      printf("   ");
    }
  }
  int i2;
  if (position2 == 7) {
    for (i2 = 0; i2 < 7;) {
      printf(" %2d",++i2);
    }
  } else {
    for (i2 = 0; i2 < (6 - position2) + 1;) {
      printf(" %2d",++i2);
    }
  }

  int day3 = 0;
  day3 = [Days daysOfUntilLastMonth:year yue:3];
  int position3 = (day3 + 5) % 7 + 1;
  printf(" ");
  if (position3 == 7) {
  }else{
    for (int i = 0; i < position3; i++) {
      printf("   ");
    }
  }
  
  int i3;
  if (position3 == 7) {
    for (i3 = 0; i3 < 7;) {
      printf(" %2d",++i3);
    }
  } else {
    for (i3 = 0; i3 < (6 - position3) + 1;) {
      printf(" %2d",++i3);
    }
  }
  printf("\n");

  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  BOOL flag1 = true;
  BOOL flag2 = true;
  BOOL flag3 = true;

  while (flag1 || flag2 || flag3) {
    for (; true; ) {
      if (i1 >= 31) {
        printf("   ");
        flag1 = false;
      }else{
        printf(" %2d",++i1);
      }
      count1++;
      if (count1 == 7) {
        count1 = 0;
        printf(" ");
        for (; true ; ) {
          if (i2 >= ([Days isLeapYear:year] == true ? 29 : 28)) {
            printf("   ");
            flag2 = false;
          }else{
            printf(" %2d",++i2);
          }
          count2++;
          if (count2 == 7) {
            count2 = 0;
            printf(" ");
            for (; true; ) {
              if (i3 >= 31) {
                flag3 = false;
              } else {
                printf(" %2d",++i3);
              }
              
              count3++;
              if (count3 == 7) {
                count3 = 0;
                printf("\n");
                break;
              }
            }
            break;
          }
        }
        break;
      }
    }
    
  }
  printf("        April                  May                   June\n");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf("\n");

  int day4 = 0;

  day4 = [Days daysOfUntilLastMonth:year yue:4];
  int position4 = (day4 + 5) % 7 + 1;
  
  if (position4 == 7) {
  }else{
    for (int i = 0; i < position4; i++) {
      printf("   ");
    }
  }
  int i4;
  if (position4 == 7) {
    for (i4 = 0; i4 < 7;) {
      printf(" %2d",++i4);
    }
  } else {
    for (i4 = 0; i4 < (6 - position4) + 1;) {
      printf(" %2d",++i4);
    }
  }
  int day5 = 0;
  day5 = [Days daysOfUntilLastMonth:year yue:5];
  int position5 = (day5 + 5) % 7 + 1;
  
  printf(" ");
  
  if (position5 == 7) {
  }else{
    for (int i = 0; i < position5; i++) {
      printf("   ");
    }
  }

  int i5;
  if (position5 == 7) {
    for (i5 = 0; i5 < 7;) {
      printf(" %2d",++i5);
    }
  } else {
    for (i5 = 0; i5 < (6 - position5) + 1;) {
      printf(" %2d",++i5);
    }
  }
  //开始打印3月的第一行；
  int day6 = 0;
  day6 = [Days daysOfUntilLastMonth:year yue:6];
  int position6 = (day6 + 5) % 7 + 1;
  
  printf(" ");
  if (position6 == 7) {
  }else{
    for (int i = 0; i < position6; i++) {
      printf("   ");
    }
  }
  int i6;
  if (position6 == 7) {
    for (i6 = 0; i6 < 7;) {
      printf(" %2d",++i6);
    }
  } else {
    for (i6 = 0; i6 < (6 - position6) + 1;) {
      printf(" %2d",++i6);
    }
  }
  printf("\n");
  
  int count4 = 0;
  int count5 = 0;
  int count6 = 0;
  BOOL flag4 = true;
  BOOL flag5 = true;
  BOOL flag6 = true;
  
  while (flag4 || flag5 || flag6) {

    for (; true; ) {
      if (i4 >= 30) {
        printf("   ");
        flag4 = false;
      }else{
        printf(" %2d",++i4);
      }
      count4++;
      if (count4 == 7) {
        count4 = 0;

        printf(" ");
        for (; true ; ) {
          if (i5 >= 31) {
            printf("   ");
            flag5 = false;
          }else{
            printf(" %2d",++i5);
          }
          count5++;
          if (count5 == 7) {
            count5 = 0;
            printf(" ");
            for (; true; ) {
              if (i6 >= 30) {
                flag6 = false;
              }else{
                printf(" %2d",++i6);
              }
              count6++;
              if (count6 == 7) {
                count6 = 0;
                printf("\n");
                break;
              }
            }
            break;
          }
        }
        break;
      }
    }
    
  }
 
  printf("         July                 August               September\n");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf("\n");

  int day7 = 0;

  day7 = [Days daysOfUntilLastMonth:year yue:7];
  int position7 = (day7 + 5) % 7 + 1;
  
  if (position7 == 7) {
  }else{
    for (int i = 0; i < position7; i++) {
      printf("   ");
    }
  }
  
  int i7;
  if (position7 == 7) {
    for (i7 = 0; i7 < 7;) {
      printf(" %2d",++i7);
    }
  } else {
    for (i7 = 0; i7 < (6 - position7) + 1;) {
      printf(" %2d",++i7);
    }
  }
  
  int day8 = 0;
  day8 = [Days daysOfUntilLastMonth:year yue:8];
  int position8 = (day8 + 5) % 7 + 1;
  
  printf(" ");
  
  if (position8 == 7) {
  }else{
    for (int i = 0; i < position8; i++) {
      printf("   ");
    }
  }
  int i8;
  if (position8 == 7) {
    for (i8 = 0; i8 < 7;) {
      printf(" %2d",++i8);
    }
  } else {
    for (i8 = 0; i8 < (6 - position8) + 1;) {
      printf(" %2d",++i8);
    }
  }
  
  int day9 = 0;
  day9 = [Days daysOfUntilLastMonth:year yue:9];
  int position9 = (day9 + 5) % 7 + 1;
  
  printf(" ");
  
  if (position9 == 7) {
  }else{
    for (int i = 0; i < position9; i++) {
      printf("   ");
    }
  }
  
  int i9;
  if (position9 == 7) {
    for (i9 = 0; i9 < 7;) {
      printf(" %2d",++i9);
    }
  } else {
    for (i9 = 0; i9 < (6 - position9) + 1;) {
      printf(" %2d",++i9);
    }
  }
  printf("\n");
  
  int count7 = 0;
  int count8 = 0;
  int count9 = 0;
  BOOL flag7 = true;
  BOOL flag8 = true;
  BOOL flag9 = true;
  
  while (flag7 || flag8 || flag9) {

    for (; true; ) {
      if (i7 >= 31) {
        printf("   ");
        flag7 = false;
      }else{
        printf(" %2d",++i7);
      }
      count7++;
      if (count7 == 7) {
        count7 = 0;
        //打印8月的第二行;
        printf(" ");
        for (; true ; ) {
          if (i8 >= 31) {
            printf("   ");
            flag8 = false;
          }else{
            printf(" %2d",++i8);
          }
          count8++;
          if (count8 == 7) {
            count8 = 0;
            //打印9月的第二行；
            printf(" ");
            for (; true; ) {
              if (i9 >= 30) {
                flag9 = false;
              }else{
                printf(" %2d",++i9);
              }
              count9++;
              if (count9 == 7) {
                count9 = 0;
                printf("\n");
                break;
              }
            }
            break;
          }
        }
        break;
      }
    }
    
  }
  printf("        October               November             December\n");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf(" Su Mo Tu We Th Fr Sa ");
  printf("\n");
  
  int day10 = 0;

  day10 = [Days daysOfUntilLastMonth:year yue:10];
  int position10 = (day10 + 5) % 7 + 1;
  
  if (position10 == 7) {
  }else{
    for (int i = 0; i < position10; i++) {
      printf("   ");
    }
  }
  
  int i10;
  if (position10 == 7) {
    for (i10 = 0; i10 < 7;) {
      printf(" %2d",++i10);
    }
  } else {
    for (i10 = 0; i10 < (6 - position10) + 1;) {
      printf(" %2d",++i10);
    }
  }

  int day11 = 0;
  day11 = [Days daysOfUntilLastMonth:year yue:11];
  int position11 = (day11 + 5) % 7 + 1;
  
  printf(" ");
  
  if (position11 == 7) {
  }else{
    for (int i = 0; i < position11; i++) {
      printf("   ");
    }
  }
  
  int i11;
  if (position11 == 7) {
    for (i11 = 0; i11 < 7;) {
      printf(" %2d",++i11);
    }
  } else {
    for (i11 = 0; i11 < (6 - position11) + 1;) {
      printf(" %2d",++i11);
    }
  }

  int day12 = 0;
  day12 = [Days daysOfUntilLastMonth:year yue:12];
  int position12 = (day12 + 5) % 7 + 1;
  
  printf(" ");
  
  if (position12 == 7) {
  }else{
    for (int i = 0; i < position12; i++) {
      printf("   ");
    }
  }

  int i12;
  if (position12 == 7) {
    for (i12 = 0; i12 < 7;) {
      printf(" %2d",++i12);
    }
  } else {
    for (i12 = 0; i12 < (6 - position12) + 1;) {
      printf(" %2d",++i12);
    }
  }
  printf("\n");

  int count10 = 0;
  int count11 = 0;
  int count12 = 0;
  BOOL flag10 = true;
  BOOL flag11 = true;
  BOOL flag12 = true;
  
  while (flag10 || flag11 || flag12) {
    for (; true; ) {
      if (i10 >= 31) {
        printf("   ");
        flag10 = false;
      }else{
        printf(" %2d",++i10);
      }
      count10++;
      if (count10 == 7) {
        count10 = 0;
        printf(" ");
        for (; true ; ) {
          if (i11 >= 30) {
            printf("   ");
            flag11 = false;
          }else{
            printf(" %2d",++i11);
          }
          count11++;
          if (count11 == 7) {
            count11 = 0;
          
            printf(" ");
            for (; true; ) {
              if (i12 >= 31) {
                flag12 = false;
              }else{
                printf(" %2d",++i12);
              }
              count12++;
              if (count12 == 7) {
                count12 = 0;
                printf("\n");
                break;
              }
            }
            break;
          }
        }
        break;
      }
    }
    
  }
  printf("\n");
}

@end
