#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorViewController.h"
#import "UIImage+ColorFromImage.h"
#import "Activity.h"

@implementation NewActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *highlightColor = [UIColor colorWithRed:0.267 green:0.616 blue:0.267 alpha:1];
    [self.findNewActivityButton setBackgroundImage:[UIImage imageWithColor:
                    highlightColor]
                                          forState:UIControlStateHighlighted];
}

- (IBAction)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

- (void)activitySelected:(Activity *)activity {
    [self.delegate activitySelected:activity];
}

@end