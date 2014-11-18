#import <UIKit/UIKit.h>
#import "WeightChangedDelegate.h"

@class PlateViewController;
@class ContextViewController;
@class HTAutocompleteTextField;

@interface WorkoutController : UIViewController <UITextFieldDelegate, WeightChangedDelegate> {
}

@property(weak, nonatomic) IBOutlet HTAutocompleteTextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic) struct CGRect const keyboardRect;
@end
