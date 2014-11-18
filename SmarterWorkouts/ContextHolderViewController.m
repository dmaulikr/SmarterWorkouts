#import "ContextHolderViewController.h"
#import "ContextViewController.h"

@implementation ContextHolderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOpened:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardClosed:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardClosed:(id)keyboardClosed {
    self.keyboardRect = CGRectZero;

    if (self.contextController) {
        [self.contextController adjustBottomConstraintForKeyboard:self.keyboardRect];
    }
}

- (void)keyboardOpened:(NSNotification *)notification {
    NSDictionary *d = [notification userInfo];
    CGRect r = [d[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardRect = [self.view convertRect:r fromView:nil];

    if (self.contextController) {
        [self.contextController adjustBottomConstraintForKeyboard:self.keyboardRect];
    }
}

- (void)showContext:(NSString *)nibName {
    if (!self.contextController) {
        self.contextController = [self addContextWithName:nibName];
        self.contextController.keyboardHeight = self.keyboardRect.size.height;
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