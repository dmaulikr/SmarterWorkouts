#import <UIKit/UIKit.h>

@class WorkoutController;
@protocol WeightChangedDelegate;
@class Form;

@interface ActivityWeightFormViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *weightInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *repsInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *setsInput;

@property(nonatomic, weak) NSObject<WeightChangedDelegate> *weightChangedDelegate;

@property(nonatomic, strong) Form *form;

- (void)attachBelow:(UIView *)field inView:(UIView *)view;
@end