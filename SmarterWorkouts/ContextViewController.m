#import "ContextViewController.h"

@implementation ContextViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleShowMoreLess:)];
    [self.view addGestureRecognizer:recognizer];
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
                                                            toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:400];
    [parentView addConstraint:self.contextTopConstraint];
    [parentView addConstraint:self.heightConstraint];
    [self.view layoutIfNeeded];
}

- (void)toggleShowMoreLess:(id)gesture {
    if (self.expanded) {
        [self showLess];
    }
    else {
        [self showMore];
    }
    self.expanded = !self.expanded;
}

- (void)showMore {
    [self.moreLabel setText:@"less"];
    [self.moreLabel layoutIfNeeded];
    self.contextTopConstraint.constant = -[self expandedHeight];
    [self animateChanges:^(BOOL b) {
    }];
}

- (void)showLess {
    [self.moreLabel setText:@"more"];
    [self.moreLabel layoutIfNeeded];
    [self animateIn];
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