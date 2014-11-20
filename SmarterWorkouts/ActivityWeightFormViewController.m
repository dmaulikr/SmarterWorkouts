#import "ActivityWeightFormViewController.h"
#import "Form.h"
#import "DecimalNumbers.h"
#import "WorkoutController.h"
#import "FlavorTextUITextField.h"
#import "WeightInputControls.h"

@implementation ActivityWeightFormViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.form = [[Form alloc] initWithFields:@[self.repsInput, self.setsInput]];
    [self.form setDelegate:self];

    [self.weightInput addTarget:self action:@selector(weightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.weightInput setDelegate:self];
    [self.weightInput setFlavor: @"lbs"];
    [WeightInputControls setup:self.weightInput];

    [self.repsInput setDelegate:self];
    [self.repsInput setFlavor:@"reps"];

    [self.setsInput setDelegate:self];
    [self.setsInput setFlavor:@"sets"];

    const int CORNER_RADIUS = 10;
    self.cancelButton.layer.cornerRadius = CORNER_RADIUS;
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.borderColor = [self.cancelButton currentTitleColor].CGColor;

    self.addButton.layer.cornerRadius = CORNER_RADIUS;
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [self.addButton currentTitleColor].CGColor;

    [self.weightInput becomeFirstResponder];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    if ([weight compare:[NSDecimalNumber decimalNumberWithString:@"45"]] == NSOrderedDescending) {
        [self.weightChangedDelegate weightChanged:weight];
    }
}

- (void)closeButtonTapped {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.weightInput) {
        NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
        if ([weight compare:[NSDecimalNumber zero]] != NSOrderedSame) {
            [self.weightChangedDelegate weightChanged:weight];
        }
    }
    else {
        [self.weightChangedDelegate weightDoneEditing];
    }

    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) removeFlavor];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.weightInput) {
        [self.weightChangedDelegate weightDoneEditing];
    }

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