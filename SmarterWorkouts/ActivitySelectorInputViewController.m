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
    [UIImageViewHelper makeWhite:self.repeatImage];
    [UIImageViewHelper makeWhite:self.addImageView];
}

- (void)activitySelected:(Activity *)activity {
    [self.delegate activitySelected:activity];
}

- (void)activityRepeated {
}


- (void)copyWorkout:(Workout *)workout {
}

- (IBAction)repeatButtonTapped:(id)sender {
    [self.delegate activityRepeated];
}

@end