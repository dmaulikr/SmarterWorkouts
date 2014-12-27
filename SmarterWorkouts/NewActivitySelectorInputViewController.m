#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorViewController.h"
#import "UIImage+ColorFromImage.h"
#import "Activity.h"
#import "Colors.h"
#import "UIImageViewHelper.h"
#import "HistoryViewController.h"
#import "Workout.h"

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
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)showHistorySelector:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HistoryViewController" bundle:nil];
    HistoryViewController *history = [sb instantiateViewControllerWithIdentifier:@"historyViewController"];
    history.selectionDelegate = self;
    [self.navigationController pushViewController:history animated:YES];
}

- (void)workoutSelected:(Workout *)workout {
    [self.delegate copyWorkout:workout];
}

- (void)activitySelected:(Activity *)activity {
    [self.delegate activitySelected:activity];
}

- (void)activityRepeated {
}

- (void)copyWorkout:(Workout *)workout {
}


@end