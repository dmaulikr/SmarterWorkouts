#import "SWTestCase.h"
#import "WorkoutController.h"
#import "NSManagedObject+MagicalFinders.h"
#import "Activity.h"
#import "NSManagedObject+MagicalRecord.h"
#import "Set.h"

@interface WorkoutControllerTests : SWTestCase
@end

@implementation WorkoutControllerTests

- (void)testGetsActivityTypeForActivity {
    WorkoutController *controller = [WorkoutController new];
    Activity *activity = [Activity MR_findFirst];
    activity.type = @"new";
    controller.selectedActivity = activity;
    XCTAssertNotNil(activity.type);
    XCTAssertEqualObjects([controller activityType], activity.type);
}

- (void)testGetsActivityTypeForSet {
    WorkoutController *controller = [WorkoutController new];
    Activity *activity = [Activity MR_findFirst];
    activity.type = @"new";
    controller.selectedSet = [Set MR_createEntity];
    controller.selectedSet.activity = activity.name;
    XCTAssertNotNil(activity.type);
    XCTAssertEqualObjects([controller activityType], activity.type);
}

@end