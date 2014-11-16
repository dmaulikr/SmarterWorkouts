#import "PlateViewController.h"

@implementation PlateViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reveal:)];
    [self.view addGestureRecognizer:recognizer];
}

- (CGFloat)initialHeight {
    return 85;
}

- (CGFloat)expandedHeight {
    return 160;
}

- (void)attachToBottomOfView:(UIView *)parentView {
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
    [parentView addConstraint:self.contextTopConstraint];
    [self.view layoutIfNeeded];
}

- (void)reveal:(id)reveal {
    NSLog(@"EXPAND");
    self.contextTopConstraint.constant = -[self expandedHeight];
    [self animateChanges:^(BOOL b) {
    }];
}

- (void)animateIn {
    self.contextTopConstraint.constant = -[self initialHeight];
    [self animateChanges:^(BOOL b) {
    }];
}

- (void)animateOut:(void (^)(BOOL))completion {
    self.contextTopConstraint.constant = 0;
    [self animateChanges:completion];
}

- (void)animateChanges:(void (^)(BOOL))completion {
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    }                completion:completion];
}

@end