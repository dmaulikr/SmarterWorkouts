#import "SWTestCase.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "FixtureLoader.h"
#import "Activity.h"

@implementation SWTestCase

- (void)setUp {
    [super setUp];

    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Workout MR_truncateAllInContext:localContext];
        [Activity MR_truncateAllInContext:localContext];
        [[FixtureLoader instance] loadDataInContext: localContext];
    }];
}

@end