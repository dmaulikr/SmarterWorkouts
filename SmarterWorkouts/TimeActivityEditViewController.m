#import "TimeActivityEditViewController.h"
#import "Activity.h"

@implementation TimeActivityEditViewController

- (void)addExtraInfo:(Activity *)activity {
    activity.type = @"timer";
}

- (void)setupInitialActivity:(Activity *)activity {
    [self.view setHidden:activity == nil];
    if (![activity.type isEqualToString:(NSString *) ACTIVITY_TIMER]) {
        [self.view setHidden:YES];
    }
}

@end