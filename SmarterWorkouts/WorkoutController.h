#import <UIKit/UIKit.h>
#import "WeightFormDelegate.h"
#import "ContextHolderViewController.h"
#import "ActivitySelectorDelegate.h"

@class PlateViewController;
@class ContextViewController;
@class ActivityWeightFormCell;
@class Workout;

@interface WorkoutController : UITableViewController <UITextFieldDelegate, ActivitySelectorDelegate, WeightFormDelegate> {
}

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic, strong) ActivityWeightFormCell *formController;
@property(nonatomic, strong) Workout *workout;
@property(nonatomic, strong) Activity *seletedActivity;
@end
