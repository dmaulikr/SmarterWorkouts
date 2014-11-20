#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WorkoutController;
@protocol ActivitySelectorDelegate;

@interface ActivitySelectorViewController : UITableViewController <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>
@property(nonatomic, strong) NSArray *data;

@property(nonatomic, strong) UISearchController *searchController;

@property(nonatomic, weak) NSObject<ActivitySelectorDelegate> *delegate;

- (instancetype)initWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate;

+ (instancetype)controllerWithDelegate:(NSObject <ActivitySelectorDelegate> *)delegate;

@end