//
//  KeyboardView.h
//  Timi
//
//
//  Created by abby on 18/12/11.
//

#import <UIKit/UIKit.h>
#import "TimiDelegate.h"

@interface KeyboardView : UIView

@property (nonatomic, assign) BOOL isShrink;
@property (weak, nonatomic) IBOutlet UIImageView *contentLogo;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentCostLabel;

@property (nonatomic, weak) id<ItemCompleteDelegate>delegate;

@end
