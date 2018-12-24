//
//  TimiTableViewController.h
//  Timi
//
//
//  Created by abby on 18/12/11.
//

#import <UIKit/UIKit.h>



@interface TimiTableViewController<ItemCompleteDelegate> : UITableViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end
