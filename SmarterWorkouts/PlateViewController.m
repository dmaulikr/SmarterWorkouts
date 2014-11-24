#import "PlateViewController.h"
#import "BarLoadingSetupViewController.h"
#import "BarCalculator.h"
#import "Plate.h"

@implementation PlateViewController

- (CGFloat)initialHeight {
    return 85;
}

- (CGFloat)expandedHeight {
    return 210;
}

- (void)animateIn {
    [self animateToHeight:[self currentHeight]];
}

- (CGFloat)currentHeight {
    return (self.expanded ? [self expandedHeight] : self.initialHeight);
}

- (void)setWeight:(NSDecimalNumber *)weight {
    BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[Plate findAllSorted:@"lbs"]
                                                            barWeight:[NSDecimalNumber decimalNumberWithString:@"45"]];
    NSArray *platesToMakeWeight = [calculator platesToMakeWeight:weight];
    [self.plates setText:[platesToMakeWeight componentsJoinedByString:@", "]];
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