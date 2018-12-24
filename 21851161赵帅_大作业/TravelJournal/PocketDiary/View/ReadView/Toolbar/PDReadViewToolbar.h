//
//  PDReadViewToolbar.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/12/1.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDReadViewToolbarDelegate <NSObject>

- (void)readViewReturn;

@end

@interface PDReadViewToolbar : UIView

@property (nonatomic, weak) id<PDReadViewToolbarDelegate> delegate;

@end
