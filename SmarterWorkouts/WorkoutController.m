#import "WorkoutController.h"
#import "PlateViewController.h"

@interface WorkoutController ()
@end

@implementation WorkoutController {
}

- (IBAction)revealPlates:(id)sender {
    [self showHideContext:@"PlateViewController"];
}

- (void)showHideContext:(NSString *)nibName {
    if (!self.contextController) {
        self.contextController = [self addContextWithName:nibName];
        [self.contextController animateIn];
    }
    else {
        [self.contextController animateOut:^(BOOL finished) {
            UIViewController *vc = [self.childViewControllers lastObject];
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
            self.contextController = nil;
        }];
    }
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