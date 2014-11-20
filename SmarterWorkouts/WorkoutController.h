#import <UIKit/UIKit.h>
#import "WeightChangedDelegate.h"
#import "ContextHolderViewController.h"

@class PlateViewController;
@class ContextViewController;

@interface WorkoutController : ContextHolderViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *activityInput;

@property(nonatomic, strong) ContextViewController *contextController;
@property(nonatomic) struct CGRect const keyboardRect;
@end
