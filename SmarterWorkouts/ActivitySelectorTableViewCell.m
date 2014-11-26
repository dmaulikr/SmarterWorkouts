#import "ActivitySelectorTableViewCell.h"
#import "ActivitySelectorViewController.h"

@implementation ActivitySelectorTableViewCell

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 66);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.activityInput setDelegate:self];
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

@end