#import "HistoryCell.h"
#import "Workout.h"

@implementation HistoryCell

- (void) setWorkout: (Workout *)workout {
    [self.primaryActivityName setText:@"Squat"];
    [self.date setText:@"12/13/14"];
}

@end