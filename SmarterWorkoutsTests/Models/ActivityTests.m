#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import "SWTestCase.h"
#import "Activity.h"
#import "Set.h"

@interface ActivityTests : SWTestCase
@end

@implementation ActivityTests

- (void)testDoesNotReturnArchivedActivities {
    int count = [[Activity MR_numberOfEntities] intValue];
    Activity *dead = [Activity MR_createEntity];
    dead.archived = YES;

    NSFetchedResultsController *controller = [Activity findAllByType];
    XCTAssertEqual([controller.fetchedObjects count], count);
}

- (void)testFindByNameDoesNotReturnArchived {
    Activity *dead = [Activity MR_createEntity];
    dead.archived = YES;
    dead.name = @"DeadName";

    XCTAssertNil([Activity findByName:@"DeadName"]);
}

- (void)testFindByName {
    Activity *dead = [Activity MR_createEntity];
    dead.name = @"FindName";

    XCTAssertNotNil([Activity findByName:@"FindName"]);
}

- (void)testDeletesFullyIfNotOnASet {
    int count = [[Activity MR_numberOfEntities] intValue];
    Activity *activity = [Activity MR_createEntity];
    activity.name = @"Not on a set";
    [activity deleteEntity];

    XCTAssertEqual(count, [[Activity MR_numberOfEntities] intValue]);
}

- (void)testArchivesIfOnASet {
    int count = [[Activity MR_numberOfEntities] intValue];
    Activity *activity = [Activity MR_createEntity];
    activity.name = @"On a set";

    Set *set = [Set MR_createEntity];
    set.activity = activity;

    [activity deleteEntity];

    XCTAssertEqual([activity archived], YES);
    XCTAssertEqual([[Activity MR_numberOfEntities] intValue], count + 1);
}

@end