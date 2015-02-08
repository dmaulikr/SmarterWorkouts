#import "TimeActivityEditViewController.h"
#import "Activity.h"

@implementation TimeActivityEditViewController

- (void)addExtraInfo:(Activity *)activity {
    activity.type = @"timer";
}

- (void)setupInitialActivity:(Activity *)activity {
}

@end