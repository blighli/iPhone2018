//
//  TimiTableViewCell.h
//  Timi
//
//
//  Created by abby on 18/12/11.
//

#import <UIKit/UIKit.h>
#import "TimiItem.h"
#import "TimiDelegate.h"




@interface TimiTableViewCell : UITableViewCell

@property (nonatomic, weak) id <TimiTableViewCellDelegate> delegate;

- (void)configureCell:(TimiItem *)item;

@end


//收入cell
@interface LeftCell : TimiTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

//支出cell
@interface RightCell : TimiTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end



