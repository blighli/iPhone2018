//
//  TimiDelegate.h
//  Timi
//
//  Created by abby on 18/12/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TimiTableViewCell;

@protocol TimiTableViewCellDelegate <NSObject>

- (void)timiCellClickEditBtn:(TimiTableViewCell *)cell;
- (void)timiCellClickDeleteBtn:(TimiTableViewCell *)cell;

@end

@protocol ItemCompleteDelegate <NSObject>

- (void)finisCompletingItem:(NSString *)contentPic contentStr:(NSString *)contentStr totalCost:(double )cost timeStamp:(NSDate *)date;

@end
