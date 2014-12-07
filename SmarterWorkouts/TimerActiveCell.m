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

- (IBAction)doneButtonTapped:(id)sender {
    Set *set = [Set MR_createEntity];
    set.activity = self.selectedSet ? self.selectedSet.activity : self.activity.name;
    set.duration = @(2);
    [self.activityFormDelegate formFinished:@[set]];
}

@end