#import <UIKit/UIKit.h>
#import "FormDelegate.h"
#import "ActivityCell.h"

@class WorkoutController;
@protocol ActivityFormDelegate;
@class Form;
@class FlavorTextUITextField;
@class Activity;
@class Set;

@interface ActivityWeightFormCell : ActivityCell <UITextFieldDelegate, FormDelegate>
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property(nonatomic, strong) Form *form;
@property (weak, nonatomic) IBOutlet UILabel *platesLabel;
@property (weak, nonatomic) IBOutlet UILabel *platesLabelSubtitle;

- (int)loggedSets;

- (int)loggedReps;

@end