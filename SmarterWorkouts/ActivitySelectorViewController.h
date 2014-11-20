#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WorkoutController;

@interface ActivitySelectorViewController : UITableViewController <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>
@property(nonatomic, strong) NSArray *data;

@property(nonatomic, strong) UISearchController *searchController;
@end