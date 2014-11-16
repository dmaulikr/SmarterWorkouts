#import "PlateViewController.h"
#import "BarLoadingSetupViewController.h"

@implementation PlateViewController

- (CGFloat)initialHeight {
    return 85;
}

- (CGFloat)expandedHeight {
    return 210;
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
    [self animateToHeight:[self initialHeight]];
}

- (void)showMore {
    [self.moreLabel setText:@"less"];
    [self.moreLabel layoutIfNeeded];
    [self animateToHeight:[self expandedHeight]];
}

- (IBAction)setupBarLoading:(id)sender {
    BarLoadingSetupViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"BarLoadingViewController" owner:self options:nil][0];
    [self.parentViewController.navigationController pushViewController:controller animated:YES];
}

@end