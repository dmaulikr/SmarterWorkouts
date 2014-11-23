#import "SWTestCase.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "MagicalRecord+Actions.h"

@implementation SWTestCase

- (void)setUp {
    [super setUp];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Workout MR_truncateAllInContext:localContext];
    }];
}

@end