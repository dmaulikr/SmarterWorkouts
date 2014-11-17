#import <HTAutocompleteTextField/HTAutocompleteTextField.h>
#import "ActivityWeightFormViewController.h"

@implementation ActivityWeightFormViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)attachBelow:(UIView *)field inView:(UIView *)view {
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeBottom
                                                    multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeLeft
                                                    multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:field attribute:NSLayoutAttributeRight
                                                    multiplier:1 constant:0]];
    [self.view setAlpha:0.1];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view setAlpha:1];
    }                completion:nil];
}

@end