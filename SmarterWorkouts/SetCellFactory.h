#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Set;

@interface SetCellFactory : NSObject
+ (UITableViewCell *)cellForSet:(Set *)set tableView:(UITableView *)view indexPath:(NSIndexPath *)indexPath;

+ (void)registerNibs:(UITableView *)view;
@end