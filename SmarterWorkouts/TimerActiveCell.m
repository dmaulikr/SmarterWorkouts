#import "TimerActiveCell.h"
#import "Activity.h"

const NSString *TIMER_ACTIVE_ACTIVITY = @"activetimer";

@implementation TimerActiveCell

- (void)setActivity:(Activity *)activity {
    [super setActivity:activity];
    [self.activityName setText:activity.name];
}

@end