/**
 * @author vosamowho
 * @Date   2018/10/17
*/

#import <Foundation/Foundation.h>

#import "calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Calendar *obj = [[Calendar alloc] init];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        int month = (int)[components month];
        int year = (int)[components year];
        
        if (argc != 1 && argc != 2 && argc != 3) {
            printf("Error command!\n");
            [obj printUsage];
        }
        else if (argc == 2) {
            year = atoi(argv[1]);
            if ([obj checkYear:year]) {
                [obj printYear:year];
            }
            else {
                printf("Illegal yeat.\n");
                [obj printUsage];
            }
        }
        else {
            if (argc == 3) {
                if (strcmp(argv[1], "-m") == 0) {
                    month = atoi(argv[2]);
                }
                else {
                    month = atoi(argv[1]);
                    year = atoi(argv[2]);
                }
            }
            
            if ([obj checkYear:year]) {
                if ([obj checkMonth:month]) {
                    [obj printMonth:year :month];
                }
                else {
                    printf("Error parameters \"-m\".\n");
                    [obj printUsage];
                }
            }
            else {
                printf("Illegal year.\n");
                [obj printUsage];
            }
        }
    }
    return 0;
}
