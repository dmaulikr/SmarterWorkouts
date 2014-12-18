#import "NewActivitySelectorInputViewController.h"
#import "ActivitySelectorInputViewController.h"
#import "Activity.h"
#import "UIImage+ColorFromImage.h"
#import "UIImageViewHelper.h"

@implementation ActivitySelectorInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *highlightColor = [UIColor colorWithRed:0.192 green:0.69 blue:0.835 alpha:1];
    [self.repeatActivityButton setBackgroundImage:[UIImage imageWithColor:highlightColor] forState:UIControlStateHighlighted];
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