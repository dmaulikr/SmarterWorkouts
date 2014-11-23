#import "SWTestCase.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "FixtureLoader.h"

@implementation SWTestCase

- (void)setUp {
    [super setUp];

    while (![[FixtureLoader instance] loaded]) {
        [NSThread sleepForTimeInterval:0.1f];
    }

    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Workout MR_truncateAllInContext:localContext];
    }];
}

@end