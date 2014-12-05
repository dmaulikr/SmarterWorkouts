#import <UIKit/UIKit.h>
#import "FormDelegate.h"

@class WorkoutController;
@protocol WeightActivityFormDelegate;
@class Form;
@class FlavorTextUITextField;
@class Activity;
@class Set;

@interface ActivityWeightFormCell : UITableViewCell <UITextFieldDelegate, FormDelegate>
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic, weak) NSObject <WeightActivityFormDelegate> *weightActivityFormDelegate;

@property(nonatomic, strong) Form *form;

@property (weak, nonatomic) IBOutlet UILabel *platesLabel;
@property (weak, nonatomic) IBOutlet UILabel *platesLabelSubtitle;

@property(nonatomic, strong) Activity *activity;
@property(nonatomic, strong) Set *selectedSet;

- (int)loggedSets;

- (int)loggedReps;

@end