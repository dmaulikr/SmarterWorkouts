#import "ActivitySelectorTableViewCell.h"
#import "ActivitySelectorViewController.h"
#import "Activity.h"

@implementation ActivitySelectorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setRepeatVisible:NO];
    [self.repeatActivityButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

- (void)setRepeatVisible:(BOOL)visible {
    [self.repeatActivityButton setHidden:!visible];
    [self.repeatHeightConstraint setConstant:visible ? 50 : 0];
    [self.repeatSpacer setConstant:visible ? 8 : 0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.repeatActivityButton.layer.cornerRadius = 10;
    self.repeatActivityButton.layer.borderWidth = 1;
    self.repeatActivityButton.layer.borderColor = [self.repeatActivityButton currentTitleColor].CGColor;

    self.findNewActivityButton.layer.cornerRadius = 10;
    self.findNewActivityButton.layer.borderWidth = 1;
    self.findNewActivityButton.layer.borderColor = [self.findNewActivityButton currentTitleColor].CGColor;
}

- (IBAction)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.delegate presentViewController:nav animated:YES completion:nil];
}

- (void)activitySelected:(Activity *)activity {
    [self setActivity:activity];
    [self.delegate activitySelected:activity];
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