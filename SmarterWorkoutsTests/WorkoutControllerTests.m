#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import "SWTestCase.h"
#import "WorkoutController.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "Activity.h"
#import "CurrentWorkout.h"

@interface WorkoutControllerTests : SWTestCase
@end

@implementation WorkoutControllerTests

- (void)testDeletingSetAdjustsRepeatActivity {
    WorkoutController *controller = [self getController];
    XCTAssertNil(controller.repeatActivity);

    Set *set1 = [Set MR_createEntity];
    set1.activity = [Activity findByName:@"Squat"];
    [controller.workout.setGroups[0] addSetsObject:set1];
    [controller setRepeatActivityToLast:controller.workout];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Squat");

    Set *set2 = [Set MR_createEntity];
    set2.activity = [Activity findByName:@"Bench"];
    [controller.workout.setGroups[0] addSetsObject:set2];
    [controller setRepeatActivityToLast:controller.workout];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Bench");

    [controller.tableView reloadData];
    [controller tableView:controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete
        forRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XCTAssertEqualObjects(controller.repeatActivity.name, @"Squat");
}

- (WorkoutController *)getController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:[NSBundle mainBundle]];
    WorkoutController *controller = [storyboard instantiateInitialViewController];
    [controller viewDidLoad];
    [controller viewWillAppear:NO];
    [controller viewDidAppear:NO];
    return controller;
}

- (void)testUsesExistingWorkoutIfThereIsOne {
    XCTAssertEqualObjects([Workout MR_numberOfEntities], @0);
    Workout *workout = [Workout MR_createEntity];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    [[CurrentWorkout instance] setWorkout:workout];
    XCTAssertEqualObjects([Workout MR_numberOfEntities], @1);
    [self getController];
    XCTAssertEqualObjects([Workout MR_numberOfEntities], @1);
}

- (void)testCreatesNewWorkoutIfNoneExisting {
    XCTAssertEqualObjects([Workout MR_numberOfEntities], @0);
    WorkoutController *controller = [self getController];
    XCTAssertEqualObjects([Workout MR_numberOfEntitiesWithContext:controller.context], @1);
}

@end