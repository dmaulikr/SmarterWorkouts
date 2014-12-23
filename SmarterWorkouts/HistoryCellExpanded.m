#import "HistoryCellExpanded.h"
#import "Workout.h"
#import "UIImage+ColorFromImage.h"

@implementation HistoryCellExpanded {
    __weak IBOutlet UIButton *editButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [editButton setBackgroundImage:
                    [UIImage imageWithColor:[UIColor colorWithRed:213 / 255.0f green:116 / 255.0f blue:0 / 255.0f alpha:1.0f]]
                          forState:UIControlStateHighlighted];
}

- (void)setWorkout:(Workout *)workout {
    [super setWorkout:workout];
}

@end