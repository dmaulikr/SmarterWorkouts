#import "WorkoutController.h"
#import "PlateViewController.h"
#import "HTAutocompleteTextField.h"
#import "ActivityAutoCompleteManager.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [self.activityInput setDelegate:self];
    self.activityInput.autocompleteDataSource = [ActivityAutoCompleteManager instance];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)revealPlates:(id)sender {
    [self removeContextController];
    [self showHideContext:@"PlateViewController"];
}

- (IBAction)revealTimer:(id)sender {
    [self removeContextController];
    [self showHideContext:@"RestViewController"];
}

- (void)showHideContext:(NSString *)nibName {
    if (!self.contextController) {
        self.contextController = [self addContextWithName:nibName];
        [self.contextController animateIn];
    }
    else {
        [self.contextController animateOut:^(BOOL finished) {
            [self removeContextController];
        }];
    }
}

- (void)removeContextController {
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    self.contextController = nil;
}

- (ContextViewController *)addContextWithName:(NSString *)nibName {
    ContextViewController *controller = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil][0];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller attachToBottomOfView:self.view];
    [controller didMoveToParentViewController:self];
    [self.view bringSubviewToFront:controller.view];
    return controller;
}

@end