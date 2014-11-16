#import "RestViewController.h"

@implementation RestViewController

- (CGFloat)initialHeight {
    return 60;
}

- (void)animateIn {
    [self showHideFieldsStarting:NO];
    [super animateIn];
}

- (void)showHideFieldsStarting:(BOOL)isStarting {
    [self.justLog setHidden:isStarting];
    [self.startTimer setHidden:isStarting];

    [self.stopTimer setHidden:!isStarting];
    [self.timeRemaining setHidden:!isStarting];
}

- (IBAction)startTimer:(id)sender {
    [self showHideFieldsStarting:YES];
    [self animateToHeight: 100];
}

- (IBAction)stopTimer:(id)sender {
    [self showHideFieldsStarting:NO];
    [self animateToHeight: [self initialHeight]];
}

@end