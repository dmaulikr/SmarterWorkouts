#import "WorkoutController.h"
#import "PlateViewController.h"

@interface WorkoutController ()
@end

@implementation WorkoutController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)revealPlates:(id)sender {
    void (^completion)(BOOL) = ^(BOOL finished) {
    };

    if (!self.context) {
        PlateViewController *controller = [self addPlateContext];
        self.contextTopConstraint.constant = [controller initialHeight];
    }
    else {
        self.contextTopConstraint.constant = 0;
        completion = ^(BOOL finished) {
            UIViewController *vc = [self.childViewControllers lastObject];
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
            self.context = nil;
        };
    }

    [self.context setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.context layoutIfNeeded];
    }                completion:completion];
}

- (PlateViewController *)addPlateContext {
    PlateViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"PlateViewController" owner:self options:nil][0];
    [self addChildViewController:controller];
    self.context = controller.view;
    [self.view addSubview:self.context];
    [self.context setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.context attribute:NSLayoutAttributeLeft multiplier:1 constant:0
            ],
            [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.context attribute:NSLayoutAttributeRight multiplier:1 constant:0
            ]
    ]];
    self.contextTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.context attribute:NSLayoutAttributeTop multiplier:1 constant:0
    ];
    [self.view addConstraint:self.contextTopConstraint];
    [self.context layoutIfNeeded];
    [controller didMoveToParentViewController:self];
    return controller;
}


@end