#import "SWTestCase.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "FixtureLoader.h"
#import "Activity.h"
#import "Plate.h"

@implementation SWTestCase

- (void)setUp {
    [super setUp];

    [Workout MR_truncateAll];
    [Activity MR_truncateAll];
    [Plate MR_truncateAll];
    [[FixtureLoader instance] loadDataInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end