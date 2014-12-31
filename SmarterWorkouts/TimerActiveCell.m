#import "TimerActiveCell.h"
#import "Activity.h"
#import "Set.h"
#import "NSManagedObject+MagicalRecord.h"
#import "ActivityFormDelegate.h"
#import "DurationDisplay.h"
#import "SWTimer.h"

const NSString *TIMER_ACTIVE_ACTIVITY = @"activetimer";

@implementation TimerActiveCell

- (void)setActivity:(Activity *)activity {
    [super setActivity:activity];
    [self.activityName setText:activity.name];
}

- (void)setFormChangeOptions:(NSDictionary *)formChangeOptions {
    [super setFormChangeOptions:formChangeOptions];
    NSNumber *minutes = formChangeOptions[@"minutes"];
    NSNumber *seconds = formChangeOptions[@"seconds"];
    self.totalSeconds = [minutes intValue] * 60 + [seconds intValue];
    [self.durationLabel setText:[DurationDisplay displayTimerFromSeconds:@(self.totalSeconds)]];
    [[SWTimer instance] setObserver:self];
    if (![[SWTimer instance] isRunning]) {
        [[SWTimer instance] start:self.totalSeconds];
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    [[SWTimer instance] stopTimer];
    Set *set = [Set MR_createEntityInContext:self.context];
    set.activity = self.selectedSet ? self.selectedSet.activity : [self.activity MR_inContext:self.context];
    set.duration = @(self.totalSeconds);
    [self.activityFormDelegate formFinished:@[set]];
}

- (void)timerTick {
    dispatch_async(dispatch_get_main_queue(), ^{
        int secondsRemaining = [[SWTimer instance] secondsRemaining];
        if (secondsRemaining <= 0) {
            [self doneButtonTapped:nil];
        }
        else {
            [self.durationLabel setText:[DurationDisplay displayTimerFromSeconds:@(secondsRemaining)]];
        }
    });
}

@end