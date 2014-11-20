#import "ContextHolderViewController.h"
#import "ContextViewController.h"

@implementation ContextHolderViewController

- (void)showContext:(NSString *)nibName {
    if (!self.contextController) {
        self.contextController = [self addContextWithName:nibName];
        [self.contextController animateIn];
    }
}

- (void)removeContextController {
    [self.contextController willMoveToParentViewController:nil];
    [self.contextController.view removeFromSuperview];
    [self.contextController removeFromParentViewController];
    self.contextController = nil;
}

- (ContextViewController *)addContextWithName:(NSString *)nibName {
    ContextViewController *controller = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil][0];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller attachToBottomOfView:self.view];
    [controller didMoveToParentViewController:self];
    return controller;
}

@end