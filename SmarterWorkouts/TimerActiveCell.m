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
    Set *set = [Set MR_createEntity];
    set.activity = self.selectedSet ? self.selectedSet.activity : self.activity.name;
    set.duration = @(self.totalSeconds);
    [self.activityFormDelegate formFinished:@[set]];
}

- (void)timerTick {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.durationLabel setText:[DurationDisplay displayTimerFromSeconds:@([[SWTimer instance] secondsRemaining])]];
    });
}

@end