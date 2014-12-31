#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Set;
@class Activity;
@class NSManagedObjectContext;

@interface ActivityCellFactory : NSObject

+ (id)cellForSelectedActivity:(Activity *)selectedActivity selectedSet:(Set *)selectedSet setToCopy:(Set *)setToCopy formChangeType:(NSString *)formChangeType formChangeOptions:(NSDictionary *)formChangeOptions tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath context:(NSManagedObjectContext *)context;

+ (NSString *)activityTypeForSelectedActivity:(Activity *)selectedActivity selectedSet:(Set *)selectedSet;

+ (void)registerNibs:(UITableView *)view;
@end