#import <UIKit/UIKit.h>

@class PlateViewController;
@class ContextViewController;
@class HTAutocompleteTextField;

@interface WorkoutController : UIViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet HTAutocompleteTextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@end
