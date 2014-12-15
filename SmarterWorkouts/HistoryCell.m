#import "HistoryCell.h"
#import "Workout.h"

@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [UIView new];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:57 / 255.0f green:139 / 255.0f blue:255 / 255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
}


- (void)setWorkout:(Workout *)workout {
    [self.primaryActivityName setText:@"Squat"];

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.date setText:[dateFormatter stringFromDate:[NSDate date]]];
}

@end