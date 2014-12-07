#import "SWTestCase.h"
#import "Activity.h"
#import "NSManagedObject+MagicalFinders.h"
#import "ActivityCellFactory.h"
#import "Set.h"
#import "NSManagedObject+MagicalRecord.h"

@interface ActivityCellFactoryTests : SWTestCase
@end

@implementation ActivityCellFactoryTests

- (void)testGetsActivityTypeForActivity {
    Activity *activity = [Activity MR_findFirst];
    activity.type = @"new";
    NSString *type = [ActivityCellFactory activityTypeForSelectedActivity:activity selectedSet:nil];
    XCTAssertNotNil(activity.type);
    XCTAssertEqualObjects(type, activity.type);
}

- (void)testGetsActivityTypeForSet {
    Activity *activity = [Activity MR_findFirst];
    activity.type = @"new";
    Set *selectedSet = [Set MR_createEntity];
    selectedSet.activity = activity.name;
    XCTAssertNotNil(activity.type);

    NSString *type = [ActivityCellFactory activityTypeForSelectedActivity:nil selectedSet:selectedSet];
    XCTAssertEqualObjects(type, activity.type);
}

@end