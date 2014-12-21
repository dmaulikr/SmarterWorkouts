#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class NSFetchedResultsController;

@interface ActivitySelectorViewController : UITableViewController <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property(nonatomic, strong) UISearchController *searchController;

@property(nonatomic, weak) NSObject<ActivitySelectorDelegate> *delegate;

@property(nonatomic, strong) NSFetchedResultsController *data;

@property(nonatomic, strong) NSFetchedResultsController *filteredData;

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate;

@end