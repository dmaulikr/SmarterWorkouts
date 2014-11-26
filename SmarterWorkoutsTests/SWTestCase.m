#import "SWTestCase.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "FixtureLoader.h"
#import "MagicalRecord+Setup.h"

@implementation SWTestCase

- (void)setUp {
    [super setUp];

    [MagicalRecord cleanUp];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];

    [[FixtureLoader instance] loadDataInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end