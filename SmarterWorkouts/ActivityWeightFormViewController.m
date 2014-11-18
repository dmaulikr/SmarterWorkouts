#import <HTAutocompleteTextField/HTAutocompleteTextField.h>
#import "ActivityWeightFormViewController.h"
#import "Form.h"
#import "DecimalNumbers.h"
#import "WorkoutController.h"

@implementation ActivityWeightFormViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.form = [[Form alloc] initWithFields:@[self.weightInput, self.repsInput, self.setsInput]];
    [self.form setDelegate:self];
    [self.weightInput addTarget:self action:@selector(weightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.weightInput setDelegate:self];
    [self.repsInput setDelegate:self];
    [self.setsInput setDelegate:self];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    [self.weightChangedDelegate weightChanged:weight];
}

- (void)closeButtonTapped {
    self.closing = YES;
    [self.view endEditing:YES];
    self.closing = NO;
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
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.weightInput && !self.closing) {
        [self.weightChangedDelegate weightDoneEditing];
    }
}


- (void)attachBelow:(UIView *)field inView:(UIView *)view {
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeBottom
                                                    multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeLeft
                                                    multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeRight
                                                    multiplier:1 constant:0]];
    [self.view setAlpha:0.1];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view setAlpha:1];
    }                completion:nil];
}

@end