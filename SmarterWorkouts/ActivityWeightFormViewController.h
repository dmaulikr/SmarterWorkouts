#import <UIKit/UIKit.h>
#import "FormDelegate.h"

@class WorkoutController;
@protocol WeightFormDelegate;
@class Form;
@class FlavorTextUITextField;

@interface ActivityWeightFormViewController : UIViewController <UITextFieldDelegate, FormDelegate>
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property(nonatomic, weak) NSObject <WeightFormDelegate> *weightFormDelegate;

@property(nonatomic, strong) Form *form;

- (void)attachBelow:(UIView *)parentView;
@end