#import "PlateViewController.h"
#import "BarLoadingSetupViewController.h"

@implementation PlateViewController

- (CGFloat)initialHeight {
    return 85;
}

- (CGFloat)expandedHeight {
    return 220;
}

- (IBAction)setupBarLoading:(id)sender {
    BarLoadingSetupViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"BarLoadingViewController" owner:self options:nil][0];
    [self.parentViewController.navigationController pushViewController:controller animated:YES];
}

@end