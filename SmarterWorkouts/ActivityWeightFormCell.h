#import <UIKit/UIKit.h>
#import "FormDelegate.h"

@class WorkoutController;
@protocol WeightFormDelegate;
@class Form;
@class FlavorTextUITextField;
@class Activity;

@interface ActivityWeightFormCell : UITableViewCell <UITextFieldDelegate, FormDelegate>
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property(nonatomic, weak) NSObject <WeightFormDelegate> *weightFormDelegate;

@property(nonatomic, strong) Form *form;

@property (weak, nonatomic) IBOutlet UILabel *platesLabel;
@property (weak, nonatomic) IBOutlet UILabel *platesLabelSubtitle;

@property(nonatomic, strong) Activity *activity;

- (int)loggedSets;

- (int)loggedReps;
@end