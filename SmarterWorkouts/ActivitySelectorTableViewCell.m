#import "ActivitySelectorTableViewCell.h"
#import "ActivitySelectorViewController.h"
#import "Activity.h"

@implementation ActivitySelectorTableViewCell

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 66);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.activityInput setDelegate:self];
    [self setRepeatVisible:NO];
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

- (void)setActivity:(Activity *)activity {
    [self setRepeatVisible:activity != nil];
}

@end