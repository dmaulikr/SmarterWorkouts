#import "ActivityCreateController.h"
#import "Activity.h"

@implementation ActivityCreateController

- (void)addExtraInfo:(Activity *)activity {
}

- (void)setupInitialActivity:(Activity *)activity {
}

- (void)setActive:(BOOL)active {
    _active = active;
    [self.view setHidden:!active];
}

@end