#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "ActivityWeightFormCell.h"
#import "Form.h"
#import "DecimalNumbers.h"
#import "WorkoutController.h"
#import "FlavorTextUITextField.h"
#import "WeightInputControls.h"
#import "Activity.h"
#import "Set.h"
#import "Plate.h"
#import "BarCalculator.h"

@implementation ActivityWeightFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
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

    self.platesLabel.alpha = 0;
    self.platesLabelSubtitle.alpha = 0;
}

- (void)prepareForReuse {
    self.activity = nil;
    self.selectedSet = nil;
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.weightInput setText:@""];
    [self.repsInput setText:@""];
    [self.setsInput setText:@""];
}

- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [self.activityNameLabel setText:self.activity.name];
    [self.setsInput setText:@""];

    [self.weightInput becomeFirstResponder];
}

- (void)setSelectedSet:(Set *)selectedSet {
    _selectedSet = selectedSet;
    [self.activityNameLabel setText:selectedSet.activity];
    [self.setsInput setText:@""];
    if ([selectedSet.weight compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
        [self.weightInput setText:[NSString stringWithFormat:@"%@", selectedSet.weight]];
    }
    else {
        [self.weightInput setText:@""];
    }

    if ([selectedSet.reps intValue] == 1) {
        [self.repsInput setText:@""];
    }
    else {
        [self.repsInput setText:[NSString stringWithFormat:@"%@", selectedSet.reps]];
    }
    [self.addButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"Delete" forState:UIControlStateNormal];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    if ([weight compare:[NSDecimalNumber decimalNumberWithString:@"45"]] == NSOrderedDescending) {
        BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[Plate findAllSorted:self.activity.units]
                                                                barWeight:[NSDecimalNumber decimalNumberWithString:@"45"]];
        NSArray *platesToMakeWeight = [calculator platesToMakeWeight:weight];
        NSString *platesText = [platesToMakeWeight componentsJoinedByString:@", "];
        if (self.platesLabel.alpha > 0) {
            [UIView transitionWithView:self.platesLabel duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self.platesLabel setText:platesText];
            }               completion:nil];
        }
        else {
            [self.platesLabel setText:platesText];
        }

        [UIView animateWithDuration:0.3 animations:^{
            [self.platesLabel setText:[platesToMakeWeight componentsJoinedByString:@", "]];
            self.platesLabel.alpha = 1;
            self.platesLabelSubtitle.alpha = 1;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.platesLabel.alpha = 0;
            self.platesLabelSubtitle.alpha = 0;
        }];
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    if (self.selectedSet) {
        [self.weightActivityFormDelegate formDelete];
    }
    else {
        [self.weightActivityFormDelegate formCanceled];
    }
}

- (IBAction)addButtonTapped:(id)sender {
    NSMutableArray *sets = [@[] mutableCopy];

    for (int setIndex = 0; setIndex < [self loggedSets]; setIndex++) {
        Set *set = nil;
        set = [Set MR_createEntity];
        set.activity = self.selectedSet ? self.selectedSet.activity : self.activity.name;
        set.units = self.selectedSet ? self.selectedSet.units : self.activity.units;
        set.weight = [DecimalNumbers parse:self.weightInput.text];
        set.reps = @([self loggedReps]);
        [sets addObject:set];
    }

    [self.weightActivityFormDelegate formFinished:sets];
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

@end