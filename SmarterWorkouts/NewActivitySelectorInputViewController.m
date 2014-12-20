#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorViewController.h"
#import "UIImage+ColorFromImage.h"
#import "Activity.h"
#import "Colors.h"
#import "UIImageViewHelper.h"
#import "HistoryViewController.h"
#import "NSManagedObjectContext+MagicalRecord.h"
#import "NSManagedObjectContext+MagicalSaves.h"

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
    [UIImageViewHelper makeWhite:self.historyImageView];
    [UIImageViewHelper makeWhite:self.chooseActivityImageView];
}

- (IBAction)showActivitySelector {
    ActivitySelectorViewController *controller = [[ActivitySelectorViewController alloc] initWithDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)showHistorySelector:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HistoryViewController" bundle:nil];
    HistoryViewController *history = [sb instantiateViewControllerWithIdentifier:@"historyViewController"];
    [self.navigationController pushViewController:history animated:YES];
}

- (void)activitySelected:(Activity *)activity {
    [self.delegate activitySelected:activity];
}

@end