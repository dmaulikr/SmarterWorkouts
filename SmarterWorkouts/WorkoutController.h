#import <UIKit/UIKit.h>
#import "WeightFormDelegate.h"
#import "ContextHolderViewController.h"
#import "ActivitySelectorDelegate.h"

@class PlateViewController;
@class ContextViewController;
@class ActivityWeightFormViewController;
@class Workout;

@interface WorkoutController : ContextHolderViewController <UITextFieldDelegate, ActivitySelectorDelegate, WeightFormDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic, strong) ActivityWeightFormViewController *formController;
@property(nonatomic, strong) Workout *workout;
@end
