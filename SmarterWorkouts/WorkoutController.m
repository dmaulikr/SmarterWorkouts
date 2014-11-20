#import "WorkoutController.h"
#import "ActivityWeightFormViewController.h"
#import "ActivitySelectorViewController.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [self.activityInput setDelegate:self];

    self.definesPresentationContext = YES;
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

- (void)activitySelected:(NSString *)activity {
    self.activity = activity;
    [self.activityInput setHidden:YES];
    [self showFormBeneath:self.view];
}

- (void)showFormBeneath:(UIView *)view {
    ActivityWeightFormViewController *form = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormViewController" owner:self options:nil][0];
    [self addChildViewController:form];
    [self.view addSubview:form.view];
    [form attachBelow:self.view];
    [form didMoveToParentViewController:self];

    [form setWeightChangedDelegate:self];
}

- (void)weightChanged:(NSDecimalNumber *)weight {

}

- (void)weightDoneEditing {

}


@end