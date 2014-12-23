#import "HistoryCellExpanded.h"
#import "Workout.h"
#import "UIImage+ColorFromImage.h"
#import "EditWorkoutDelegate.h"

@implementation HistoryCellExpanded

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.editButton setBackgroundImage:
                    [UIImage imageWithColor:[UIColor colorWithRed:155 / 255.0f green:84 / 255.0f blue:0 / 255.0f alpha:1.0f]]
                          forState:UIControlStateHighlighted];
}

- (void)setWorkout:(Workout *)workout {
    [super setWorkout:workout];
}

- (IBAction)editButtonTapped:(id)sender {
    [self.delegate editWorkout:self.workout];
}

@end