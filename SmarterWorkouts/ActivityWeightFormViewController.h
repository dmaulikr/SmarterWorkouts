#import <UIKit/UIKit.h>
#import "FormDelegate.h"

@class WorkoutController;
@protocol WeightChangedDelegate;
@class Form;

@interface ActivityWeightFormViewController : UIViewController <UITextFieldDelegate, FormDelegate>
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *weightInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *repsInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *setsInput;

@property(nonatomic, weak) NSObject<WeightChangedDelegate> *weightChangedDelegate;

@property(nonatomic, strong) Form *form;

@property(nonatomic) BOOL closing;

- (void)attachBelow:(UIView *)field inView:(UIView *)view;
@end