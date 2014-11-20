#import "ContextViewController.h"

@implementation ContextViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewTapped:(id)gesture {
}

- (CGFloat)initialHeight {
    return 0;
}

- (CGFloat)expandedHeight {
    return [self initialHeight];
}

- (void)attachToBottomOfView:(UIView *)parentView {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:parentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0
            ],
            [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:parentView attribute:NSLayoutAttributeRight multiplier:1 constant:0
            ]
    ]];
    self.contextTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0
    ];
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[self initialHeight]];
    [parentView addConstraint:self.heightConstraint];
    [parentView addConstraint:self.contextTopConstraint];
    [self.view layoutIfNeeded];
}

- (void)animateToHeight:(CGFloat)height {
    self.contextTopConstraint.constant = -height;
    self.heightConstraint.constant = height;
    [self animateChanges:^(BOOL b) {
    }];
}

- (void)animateIn {
    [self animateToHeight:[self initialHeight]];
}

- (void)animateChanges:(void (^)(BOOL))completion {
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    }                completion:completion];
}

@end