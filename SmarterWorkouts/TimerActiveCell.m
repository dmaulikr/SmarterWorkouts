#import "TimerActiveCell.h"
#import "Activity.h"
#import "Set.h"
#import "NSManagedObject+MagicalRecord.h"
#import "ActivityFormDelegate.h"

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
    [self.durationLabel setText:[NSString stringWithFormat:@"%d", self.totalSeconds]];
}

- (IBAction)doneButtonTapped:(id)sender {
    Set *set = [Set MR_createEntity];
    set.activity = self.selectedSet ? self.selectedSet.activity : self.activity.name;
    set.duration = @(self.totalSeconds);
    [self.activityFormDelegate formFinished:@[set]];
}

@end