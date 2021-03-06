#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
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
#import "Bar.h"
#import "BarPlateSetup.h"
#import "NoteInputAccessoryView.h"

const NSString *WEIGHT_ACTIVITY = @"weight";

@implementation ActivityWeightFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [WeightInputControls addLbsKgSelector:self.weightInput delegate:self];
    self.form = [[Form alloc] initWithFields:@[self.weightInput, self.repsInput, self.setsInput]];
    [self.form setDelegate:self];

    [self.weightInput addTarget:self action:@selector(weightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.weightInput setDelegate:self];
    [self.weightInput setText:@""];

    [self.repsInput setDelegate:self];
    [self.repsInput setFlavor:@"reps"];

    [self.setsInput setDelegate:self];
    [self.setsInput setFlavor:@"sets"];

    self.platesContainer.alpha = 0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(platesContainerTapped)];
    [self.platesContainer addGestureRecognizer:tap];

    NoteInputAccessoryView *view = [[NSBundle mainBundle] loadNibNamed:@"NoteInputAccessoryView" owner:self options:nil][0];
    [self.notesHiddenInput setInputAccessoryView:view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.weightInput becomeFirstResponder];
    [self weightChanged:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.weightInput setText:@""];
    [self.repsInput setText:@""];
    [self.setsInput setText:@""];
}

- (void)setUnits:(NSString *)units {
    _units = [units mutableCopy];
    [self.weightInput setFlavor:units];
}

- (void)setActivity:(Activity *)activity {
    [super setActivity:activity];
    [self setUnits:activity.units];
    [self.deleteButton setHidden:YES];
    [self.activityNameLabel setText:self.activity.name];
    [self.setsInput setText:@""];

    [self.weightInput becomeFirstResponder];
    [self.platesContainer setHidden:!activity.usesBar];
    [self hideNotes:YES];
    [self.notesHiddenInput setText:@""];
}

- (void)hideNotes:(BOOL)shouldHide {
    [self.notesLabel setHidden:shouldHide];
    [self.notesVerticalPaddingConstraint setConstant:shouldHide ? 0 : 12];
}

- (void)setSelectedSet:(Set *)selectedSet {
    [super setSelectedSet:selectedSet];
    [self setUnits:selectedSet.units];
    [self.deleteButton setHidden:NO];
    [self.activityNameLabel setText:selectedSet.activity.name];
    [self.setsInput setText:@""];
    if ([selectedSet.weight compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
        [self.weightInput setText:[NSString stringWithFormat:@"%@", selectedSet.weight]];
    }
    else {
        [self.weightInput setText:@""];
        [self.weightInput addFlavor];
    }

    if ([selectedSet.reps intValue] == 1) {
        [self.repsInput setText:@""];
    }
    else {
        [self.repsInput setText:[NSString stringWithFormat:@"%@", selectedSet.reps]];
        [self.repsInput addFlavor];
    }

    [self.addButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.platesContainer setHidden:!selectedSet.activity.usesBar];
    [self.notesLabel setText:selectedSet.comments];
    [self hideNotes:[selectedSet.comments isEqualToString:@""]];
    [self.notesHiddenInput setText:selectedSet.comments];
}

- (void)setSetToCopy:(Set *)set {
    [self setUnits:set.units];
    if ([set.weight compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
        [self.weightInput setText:[NSString stringWithFormat:@"%@", set.weight]];
    }
    if ([set.reps intValue] == 1) {
        [self.repsInput setText:@""];
    }
    else {
        [self.repsInput setText:[NSString stringWithFormat:@"%@", set.reps]];
    }
    [self hideNotes:YES];
    [self.notesLabel setText:@""];
    [self.notesHiddenInput setText:@""];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    [self weightChanged:nil];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    if ([weight compare:[NSDecimalNumber decimalNumberWithString:@"45"]] == NSOrderedDescending) {
        Bar *bar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", self.units]];
        BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:
                        [Plate findAllSorted:self.units]
                                                                barWeight:bar.weight];
        NSArray *platesToMakeWeight = [calculator platesToMakeWeight:weight];
        NSString *platesText = [platesToMakeWeight componentsJoinedByString:@", "];
        if (self.platesContainer.alpha > 0) {
            [UIView transitionWithView:self.platesLabel duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self.platesLabel setText:platesText];
            }               completion:nil];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                [self.platesLabel setText:[platesToMakeWeight componentsJoinedByString:@", "]];
                self.platesContainer.alpha = 1;
            }];
        }
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.platesContainer.alpha = 0;
        }];
    }
}

- (IBAction)addButtonTapped:(id)sender {
    NSMutableArray *sets = [@[] mutableCopy];

    for (int setIndex = 0; setIndex < [self loggedSets]; setIndex++) {
        Set *set = nil;
        set = [Set MR_createEntityInContext:self.context];
        set.activity = self.selectedSet ? self.selectedSet.activity : [self.activity MR_inContext:self.context];
        set.units = self.selectedSet ? self.selectedSet.units : self.activity.units;
        set.weight = [DecimalNumbers parse:self.weightInput.text];
        set.reps = @([self loggedReps]);
        set.comments = [self.notesHiddenInput text];
        [sets addObject:set];
    }

    [self.activityFormDelegate formFinished:sets];
}

- (void)platesContainerTapped {
    BarPlateSetup *controller = [[NSBundle mainBundle] loadNibNamed:@"BarPlateSetup" owner:self options:nil][0];
    [controller setUnits:self.units];
    [self.activityFormDelegate segueTo:controller];
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

- (void)lbsKgsChanged:(id)control {
    self.units = [control selectedSegmentIndex] == 0 ? @"lbs" : @"kg";
    if (self.selectedSet) {
        self.selectedSet.units = self.units;
    }
    [self weightChanged:nil];
}

- (IBAction)notesTapped:(id)sender {
    [self.notesHiddenInput becomeFirstResponder];
    NoteInputAccessoryView *view = (NoteInputAccessoryView *) [self.notesHiddenInput inputAccessoryView];
    [view setDelegate:self];
    [view.messageBox setText:[self.notesHiddenInput text]];
    [view.messageBox becomeFirstResponder];
}

- (void)textSaved:(NSString *)text {
    [self.notesHiddenInput setText:text];
    [self.notesHiddenInput endEditing:YES];
    [self.notesLabel setText:text];
    [self hideNotes:[text isEqualToString:@""]];
}

@end