#import <UIKit/UIKit.h>
#import "ActivityFormDelegate.h"
#import "ActivitySelectorDelegate.h"

@class ActivityWeightFormCell;
@class Workout;
@class Set;
@class ActivitySelectorInputViewController;

@interface WorkoutController : UIViewController <UITextFieldDelegate, ActivitySelectorDelegate, ActivityFormDelegate, UITableViewDelegate, UITableViewDataSource> {
}
@property (weak, nonatomic) IBOutlet UIView *startNewActivityContainer;
@property (weak, nonatomic) IBOutlet ActivitySelectorInputViewController *activitySelectorInputController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) Workout *workout;
@property(nonatomic, strong) Activity *selectedActivity;
@property(nonatomic, strong) Set *selectedSet;

@property(nonatomic, copy) NSString *formChangeType;

@property(nonatomic, strong) NSDictionary *formChangeOptions;

@end
