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
    ActivitySelectorViewController *controller = [ActivitySelectorViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    [self showFormBeneath:self.activityInput];
//    return YES;
//}

- (void)showFormBeneath:(UITextField *)field {
    ActivityWeightFormViewController *form = [[NSBundle mainBundle] loadNibNamed:@"ActivityWeightFormViewController" owner:self options:nil][0];
    [self addChildViewController:form];
    [self.view addSubview:form.view];
    [form attachBelow:field inView:self.view];
    [form didMoveToParentViewController:self];

    [form setWeightChangedDelegate:self];
}

@end