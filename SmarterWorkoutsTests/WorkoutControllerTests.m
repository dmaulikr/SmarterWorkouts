#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "WorkoutController.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "Activity.h"

@interface WorkoutControllerTests : SWTestCase
@end

@implementation WorkoutControllerTests

- (void)testDeletingSetAdjustsRepeatActivity {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:[NSBundle mainBundle]];
    WorkoutController *controller = [storyboard instantiateInitialViewController];
    [controller viewDidLoad];
    [controller viewWillAppear:NO];
    [controller viewDidAppear:NO];
    XCTAssertNil(controller.repeatActivity);

    Set *set1 = [Set MR_createEntity];
    set1.activity = @"Squat";
    [controller.workout.setGroups[0] addSetsObject:set1];
    [controller setRepeatActivityToLast:controller.workout];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Squat");

    Set *set2 = [Set MR_createEntity];
    set2.activity = @"Bench";
    [controller.workout.setGroups[0] addSetsObject:set2];
    [controller setRepeatActivityToLast:controller.workout];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Bench");

    [controller.tableView reloadData];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete
        forRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Squat");
}

@end