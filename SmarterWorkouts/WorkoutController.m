#import "WorkoutController.h"
#import "HTAutocompleteTextField.h"
#import "ActivityAutoCompleteManager.h"
#import "ActivityWeightFormViewController.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [self.activityInput setDelegate:self];
    self.activityInput.autocompleteDataSource = [ActivityAutoCompleteManager instance];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self showFormBeneath:self.activityInput];
    return YES;
}

- (void)showFormBeneath:(HTAutocompleteTextField *)field {
    ActivityWeightFormViewController *form = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormViewController" owner:self options:nil][0];
    [self addChildViewController:form];
    [self.view addSubview:form.view];
    [form attachBelow:field inView:self.view];
    [form didMoveToParentViewController:self];

    [form setWeightChangedDelegate:self];
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    [self showContext:@"PlateViewController"];
}

- (void)weightDoneEditing {
    [self removeContextController];
}

@end