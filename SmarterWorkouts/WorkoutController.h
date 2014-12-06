#import <UIKit/UIKit.h>
#import "ActivityFormDelegate.h"
#import "ActivitySelectorDelegate.h"

@class ActivityWeightFormCell;
@class Workout;
@class Set;

@interface WorkoutController : UITableViewController <UITextFieldDelegate, ActivitySelectorDelegate, ActivityFormDelegate> {
}
@property(nonatomic, strong) Workout *workout;
@property(nonatomic, strong) Activity *selectedActivity;
@property(nonatomic, strong) Set *selectedSet;

- (NSString *)activityType;
@end
