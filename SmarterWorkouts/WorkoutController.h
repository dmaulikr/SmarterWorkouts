#import <UIKit/UIKit.h>
#import "WeightChangedDelegate.h"
#import "ContextHolderViewController.h"

@class PlateViewController;
@class ContextViewController;
@class HTAutocompleteTextField;

@interface WorkoutController : ContextHolderViewController <UITextFieldDelegate, WeightChangedDelegate> {
}

@property(weak, nonatomic) IBOutlet HTAutocompleteTextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic) struct CGRect const keyboardRect;
@end
