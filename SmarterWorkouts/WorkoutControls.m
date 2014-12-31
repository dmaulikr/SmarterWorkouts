#import "WorkoutControls.h"
#import "WorkoutControlsDelegate.h"

@implementation WorkoutControls

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.arrangeButton setTitleColor:
                    [self highlightColor]
                             forState:UIControlStateHighlighted];
}

- (UIColor *)highlightColor {
    return [UIColor colorWithRed:(CGFloat) (255.0 / 255.0) green:(CGFloat) (174 / 255.0) blue:(CGFloat) (38 / 255.0) alpha:1];
}

- (IBAction)orderButtonTapped:(id)sender {
    self.ordering = !self.ordering;
    if (self.ordering) {
        [self.arrangeButton setTitleColor:
                        [self highlightColor]
                                 forState:UIControlStateNormal];
        [self.arrangeButton setTitleColor:
                        [UIColor whiteColor]
                                 forState:UIControlStateHighlighted];
    }
    else {
        [self.arrangeButton setTitleColor:
                        [UIColor whiteColor]
                                 forState:UIControlStateNormal];
        [self.arrangeButton setTitleColor:
                        [self highlightColor]
                                 forState:UIControlStateHighlighted];
    }
    [self.delegate toggleOrdering:self.ordering];
}

@end