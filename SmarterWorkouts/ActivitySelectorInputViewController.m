#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorInputViewController.h"
#import "Activity.h"
#import "UIImage+ColorFromImage.h"
#import "UIImageViewHelper.h"
#import "Colors.h"
#import "Workout.h"

@implementation ActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.repeatActivityButton setBackgroundImage:[UIImage imageWithColor:[Colors secondaryButtonColorHighlight]] forState:UIControlStateHighlighted];
    [self.repeatActivityButton setBackgroundImage:[UIImage imageWithColor:[Colors secondaryButtonColorDisabled]] forState:UIControlStateDisabled];
    [UIImageViewHelper makeWhite:self.repeatImage];
    [UIImageViewHelper makeWhite:self.addImageView];
}

- (void)activitySelected:(Activity *)activity {
    [self.delegate activitySelected:activity];
}

- (void)setRepeatActivity:(Activity *)activity {
    [self.repeatActivityButton setEnabled:activity != nil];
}

- (void)activityRepeated {
}


- (void)copyWorkout:(Workout *)workout {
}

- (IBAction)repeatButtonTapped:(id)sender {
    [self.delegate activityRepeated];
}

@end