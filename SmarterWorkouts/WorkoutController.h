#import <UIKit/UIKit.h>

@class PlateViewController;
@class ContextViewController;

@interface WorkoutController : UIViewController <UITextFieldDelegate> {}

@property (weak, nonatomic) IBOutlet UITextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@end
