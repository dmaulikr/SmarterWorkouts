#import "ActivitySelectorTableViewCell.h"
#import "ActivitySelectorViewController.h"
#import "Activity.h"
#import "ActivitySelectorDelegate.h"

@implementation ActivitySelectorTableViewCell

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 66);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.activityInput setDelegate:self];
    [self setRepeatVisible:NO];

    [self.repeatActivityButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

- (void)setRepeatVisible:(BOOL)visible {
    [self.repeatActivityButton setHidden:!visible];
    [self.repeatHeightConstraint setConstant:visible ? 50 : 0];
    [self.repeatSpacer setConstant:visible ? 8 : 0];

    [self.activityInput setPlaceholder:visible ? @"New activity" : @"Add an activity (e.g. Squat)"];
    [self.activityInput setTextAlignment:NSTextAlignmentCenter];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.repeatActivityButton.layer.cornerRadius = 10;
    self.repeatActivityButton.layer.borderWidth = 1;
    self.repeatActivityButton.layer.borderColor = [self.repeatActivityButton currentTitleColor].CGColor;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showActivitySelector];
    return NO;
}

- (void)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self.delegate];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.delegate presentViewController:nav animated:YES completion:nil];
}

- (IBAction)repeatActivityTapped:(id)sender {
    [self.delegate activitySelected:self.repeatActivity];
}

- (void)setActivity:(Activity *)activity {
    self.repeatActivity = activity;
    [self setRepeatVisible:activity != nil];
    [self.repeatActivityButton setTitle:[NSString stringWithFormat:@"+%@", [activity name]] forState:UIControlStateNormal];
}

@end