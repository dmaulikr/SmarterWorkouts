#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Set;
@class Activity;

@interface ActivityCellFactory : NSObject

+ cellForSelectedActivity:(Activity *)selectedActivity
              selectedSet:(Set *)selectedSet
              setToCopy:(Set *)setToCopy
           formChangeType:(NSString *)formChangeType
        formChangeOptions:(NSDictionary *)formChangeOptions
                tableView:(UITableView *)tableView
                indexPath:(NSIndexPath *)indexPath;

+ (NSString *)activityTypeForSelectedActivity:(Activity *)selectedActivity selectedSet:(Set *)selectedSet;

+ (void)registerNibs:(UITableView *)view;
@end