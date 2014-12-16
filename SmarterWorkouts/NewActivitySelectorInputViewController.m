#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorViewController.h"
#import "UIImage+ColorFromImage.h"
#import "Activity.h"
#import "Colors.h"

@implementation NewActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.findNewActivityButton setBackgroundImage:[UIImage imageWithColor:
                    [Colors positiveButtonHighlight]]
                                          forState:UIControlStateHighlighted];

    [self.cpyAWorkoutButton setBackgroundColor:[Colors secondaryButtonColor]];
    [self.cpyAWorkoutButton setBackgroundImage:[UIImage imageWithColor:
                    [Colors secondaryButtonColorHighlight]]
                                      forState:UIControlStateHighlighted];
    self.historyImageView.tintColor = [UIColor whiteColor];
    self.chooseActivityImageView.tintColor = [UIColor whiteColor];
    self.historyImageView.image = [self.historyImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.chooseActivityImageView.image = [self.chooseActivityImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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