#import "WorkoutController.h"
#import "ActivityWeightFormViewController.h"
#import "ActivitySelectorViewController.h"
#import "Activity.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [self.activityInput setDelegate:self];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showActivitySelector];
    return NO;
}

- (void)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)activitySelected:(Activity *)activity {
    [self.activityInput setHidden:YES];
    [self showForm:activity];
}

- (void)showForm:(Activity *)activity {
    self.formController = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormViewController" owner:self options:nil][0];
    self.formController.activity = activity;
    [self addChildViewController:self.formController];
    [self.view addSubview:self.formController.view];
    [self.formController attachBelow:self.view];
    [self.formController didMoveToParentViewController:self];
    [self.formController setWeightFormDelegate:self];
}

- (void)weightChanged:(NSDecimalNumber *)weight {
    [self showContext:@"PlateViewController"];
}

- (void)weightDoneEditing {
}

- (void)formCanceled {
    [self removeContextController];
    [self removeFormController];
}

- (void)removeFormController {
    [UIView animateWithDuration:0.25 animations:^{
        self.formController.view.alpha = 0;
    }                completion:^(BOOL finished) {
        [self.formController willMoveToParentViewController:nil];
        [self.self.formController.view removeFromSuperview];
        [self.self.formController removeFromParentViewController];
        self.self.formController = nil;

        [self.activityInput setHidden:NO];
        self.activityInput.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.activityInput.alpha = 1;
        }                completion:nil];
    }];
}

@end