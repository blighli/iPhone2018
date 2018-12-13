
@interface NSListItem : NSObject
@property  NSInteger *itemId;
@property  NSString *itemName;

- (instancetype)initWithItem:(NSInteger*)itemId itemName:(NSString*)itemName NS_DESIGNATED_INITIALIZER;
@end
