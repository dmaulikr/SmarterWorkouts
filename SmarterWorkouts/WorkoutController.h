#import <UIKit/UIKit.h>
#import "ActivityFormDelegate.h"
#import "ActivitySelectorDelegate.h"
#import "WorkoutSelectionDelegate.h"

@class ActivityWeightFormCell;
@class Workout;
@class Set;
@class NewActivitySelectorInputViewController;
@class ActivitySelectorInputViewController;

@interface WorkoutController : UIViewController <UITextFieldDelegate, ActivitySelectorDelegate, ActivityFormDelegate, UITableViewDelegate, UITableViewDataSource> {
}
@property (weak, nonatomic) IBOutlet UIView *quoteContainer;
@property (weak, nonatomic) IBOutlet UIView *startNewActivityContainer;
@property (weak, nonatomic) IBOutlet UIView *selectActivityContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) Workout *workout;
@property(nonatomic, strong) Activity *selectedActivity;
@property(nonatomic, strong) Set *selectedSet;

@property(nonatomic, copy) NSString *formChangeType;

@property(nonatomic, strong) NSDictionary *formChangeOptions;

@property(nonatomic, strong) ActivitySelectorInputViewController *selectActivityController;
@property(nonatomic) BOOL newWorkout;
@property(nonatomic, strong) Activity *repeatActivity;
@property(nonatomic) BOOL copyLastSet;

@property(nonatomic, strong) NSManagedObjectContext *context;

- (void)setRepeatActivityToLast:(Workout *)workout;
@end
