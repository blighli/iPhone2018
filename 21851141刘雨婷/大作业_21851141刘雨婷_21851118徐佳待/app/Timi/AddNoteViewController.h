//
//  AddNoteViewController.h
//  Timi
//
//
//  Created by abby on 18/12/11.
//

#import <UIKit/UIKit.h>
#import "TimiDelegate.h"
#import "KeyboardView.h"
#import "AppDelegate.h"



@interface AddNoteViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, ItemCompleteDelegate>

@property (nonatomic, weak) id<ItemCompleteDelegate> delegate;
@property (nonatomic, strong) KeyboardView *keyboardView;

@end
