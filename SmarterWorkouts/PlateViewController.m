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
    return 200;
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
                                                            toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:400];
    [parentView addConstraint:self.contextTopConstraint];
    [parentView addConstraint:self.heightConstraint];
    [self.view layoutIfNeeded];
}

- (void)reveal:(id)reveal {
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