#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import "SWTestCase.h"
#import "Activity.h"

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

@end