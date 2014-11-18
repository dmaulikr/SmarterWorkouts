#import "PlateViewController.h"
#import "BarLoadingSetupViewController.h"

@implementation PlateViewController

- (CGFloat)initialHeight {
    return 85;
}

- (CGFloat)expandedHeight {
    return 210;
}

- (void)animateIn {
    [self animateToHeight:[self currentHeight] + self.keyboardHeight];
}

- (CGFloat)currentHeight {
    return (self.expanded ? [self expandedHeight] : self.initialHeight);
}

- (void)adjustBottomConstraintForKeyboard:(CGRect)keyboardRect {
    self.keyboardHeight = keyboardRect.size.height;
    [self animateToHeight:[self currentHeight] + keyboardRect.size.height];
}

- (void)viewTapped:(id)gesture {
    if (self.expanded) {
        [self showLess];
    }
    else {
        [self showMore];
    }
    self.expanded = !self.expanded;
}

- (void)showLess {
    [self.moreLabel setText:@"more"];
    [self.moreLabel layoutIfNeeded];
    [self animateToHeight:[self initialHeight] + self.keyboardHeight];
}

- (void)showMore {
    [self.moreLabel setText:@"less"];
    [self.moreLabel layoutIfNeeded];
    [self animateToHeight:[self expandedHeight] + self.keyboardHeight];
}

- (IBAction)setupBarLoading:(id)sender {
    BarLoadingSetupViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"BarLoadingViewController" owner:self options:nil][0];
    [self.parentViewController.navigationController pushViewController:controller animated:YES];
}

@end