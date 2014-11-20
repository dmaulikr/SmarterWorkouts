#import <UIKit/UIKit.h>
#import "FormDelegate.h"

@class WorkoutController;
@protocol WeightChangedDelegate;
@class Form;
@class FlavorTextUITextField;

@interface ActivityWeightFormViewController : UIViewController <UITextFieldDelegate, FormDelegate>
@property(weak, nonatomic) IBOutlet UITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;

@property(nonatomic, weak) NSObject <WeightChangedDelegate> *weightChangedDelegate;

@property(nonatomic, strong) Form *form;

@property(nonatomic) BOOL closing;

- (void)attachBelow:(UIView *)field inView:(UIView *)view;
@end