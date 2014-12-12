#import "ActivitySelectorInputViewController.h"
#import "ActivitySelectorViewController.h"
#import "UIImage+ColorFromImage.h"

@implementation ActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *highlightColor = [UIColor colorWithRed:0.361 green:0.514 blue:0.184 alpha:1];
    [self.findNewActivityButton setBackgroundImage:[UIImage imageWithColor:
                    highlightColor]
                                          forState:UIControlStateHighlighted];
}

- (IBAction)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self.delegate];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

@end