#import <UIKit/UIKit.h>
#import "WeightChangedDelegate.h"
#import "ContextHolderViewController.h"
#import "ActivitySelectorDelegate.h"

@class PlateViewController;
@class ContextViewController;

@interface WorkoutController : ContextHolderViewController <UITextFieldDelegate, ActivitySelectorDelegate, WeightChangedDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic) struct CGRect const keyboardRect;
@property(nonatomic, copy) NSString *activity;
@end
