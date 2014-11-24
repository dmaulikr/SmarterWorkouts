#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "ActivityWeightFormViewController.h"
#import "Form.h"
#import "DecimalNumbers.h"
#import "WorkoutController.h"
#import "FlavorTextUITextField.h"
#import "WeightInputControls.h"
#import "UIImage+ColorFromImage.h"
#import "Activity.h"
#import "Set.h"

@implementation ActivityWeightFormViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [WeightInputControls addLbsKgSelector:self.weightInput];
    self.form = [[Form alloc] initWithFields:@[self.weightInput, self.repsInput, self.setsInput]];
    [self.form setDelegate:self];

    [self.weightInput addTarget:self action:@selector(weightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.weightInput setDelegate:self];
    [self.weightInput setFlavor:@"lbs"];
    [self.weightInput setText:@""];

    [self.repsInput setDelegate:self];
    [self.repsInput setFlavor:@"reps"];

    [self.setsInput setDelegate:self];
    [self.setsInput setFlavor:@"sets"];

    self.addButton.layer.cornerRadius = 10;
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [self.addButton currentTitleColor].CGColor;

    [self.cancelButton                                        setBackgroundImage:[UIImage imageWithColor:
            [UIColor colorWithRed:0.851 green:0.325 blue:0.31 alpha:1]] forState:UIControlStateHighlighted];

    self.tapToSeePlatesLabel.alpha = 0;
    [self.weightInput becomeFirstResponder];
}

- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [self.activityNameLabel setText:self.activity.name];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    if ([weight compare:[NSDecimalNumber decimalNumberWithString:@"45"]] == NSOrderedDescending) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tapToSeePlatesLabel.alpha = 1;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.tapToSeePlatesLabel.alpha = 0;
        }];
    }
    [self.weightFormDelegate weightChanged:weight];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.weightFormDelegate formCanceled];
}

- (IBAction)addButtonTapped:(id)sender {
    NSMutableArray *sets = [@[] mutableCopy];
    for (int setIndex = 0; setIndex < [self loggedSets]; setIndex++) {
        Set *set = [Set MR_createEntity];
        set.units = self.activity.units;
        set.weight = [DecimalNumbers parse:self.weightInput.text];
        set.reps = @([self loggedReps]);
        [sets addObject:set];
    }
    [self.weightFormDelegate formFinished:sets];
}

- (int)valueOf:(UITextField *)field {
    return [[field text] isEqualToString:@""] ? 1 : [[field text] integerValue];
}

- (int)loggedSets {
    return [self valueOf:self.setsInput];
}

- (int)loggedReps {
    return [self valueOf:self.repsInput];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.weightInput) {
        NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
        if ([weight compare:[NSDecimalNumber zero]] != NSOrderedSame) {
            [self.weightFormDelegate weightChanged:weight];
        }
    }

    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) removeFlavor];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) addFlavor];
    }
}

- (void)attachBelow:(UIView *)parentView {
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeTop
                                                          multiplier:1 constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeLeft
                                                          multiplier:1 constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeRight
                                                          multiplier:1 constant:0]];
}

@end