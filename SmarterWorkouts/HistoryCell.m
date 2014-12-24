#import "HistoryCell.h"
#import "Workout.h"
#import "PrimaryActivityFinder.h"

@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [UIView new];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 / 255.0f green:116 / 255.0f blue:178 / 255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setWorkout:(Workout *)workout {
    _workout = workout;
    [self.primaryActivityName setText:[PrimaryActivityFinder primaryActivityFor:workout]];

    [self.date setText:[self formattedDateForWorkout:workout]];
}

- (NSString *)formattedDateForWorkout:(Workout *)workout {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString *formattedDate = [dateFormatter stringFromDate:workout.date];
    return formattedDate;
}

@end