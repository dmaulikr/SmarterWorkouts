#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorInputViewController.h"
#import "Activity.h"
#import "UIImage+ColorFromImage.h"
#import "UIImageViewHelper.h"
#import "Colors.h"

@implementation ActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.repeatActivityButton setBackgroundImage:[UIImage imageWithColor:[Colors secondaryButtonColorHighlight]] forState:UIControlStateHighlighted];
    [UIImageViewHelper makeWhite:self.repeatImage];
    [UIImageViewHelper makeWhite:self.addImageView];
}

- (void)activitySelected:(Activity *)activity {
    [self setLastActivity:activity];
    [self.delegate activitySelected:activity];
}

- (void)setLastActivity:(Activity *)activity {
    self.repeatActivity = activity;
    [self.repeatActivityLabel setText:activity.name];
}

- (IBAction)repeatButtonTapped:(id)sender {
    [self.delegate activitySelected:self.repeatActivity];
}

@end