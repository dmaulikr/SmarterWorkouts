#import <UIKit/UIKit.h>
#import "FormDelegate.h"
#import "ActivityCell.h"
#import "TextSaved.h"

@class WorkoutController;
@protocol ActivityFormDelegate;
@class Form;
@class FlavorTextUITextField;
@class Activity;
@class Set;

extern const NSString *WEIGHT_ACTIVITY;

@interface ActivityWeightFormCell : ActivityCell <UITextFieldDelegate, FormDelegate, TextSaved>
@property(weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *weightInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *repsInput;
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *setsInput;
@property(weak, nonatomic) IBOutlet UIButton *addButton;

@property(nonatomic, strong) Form *form;
@property(weak, nonatomic) IBOutlet UILabel *platesLabel;
@property(weak, nonatomic) IBOutlet UILabel *platesLabelSubtitle;
@property (weak, nonatomic) IBOutlet UIView *platesContainer;
@property (weak, nonatomic) IBOutlet UITextField *notesHiddenInput;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesVerticalPaddingConstraint;

@property(nonatomic, copy) NSString *units;

- (int)loggedSets;

- (int)loggedReps;

- (void)lbsKgsChanged:(id)lbsKgsChanged;
@end