#import "XCTest/XCTest.h"
#import "Workout.h"
#import "NSManagedObject+MagicalRecord.h"
#import "SetGroup.h"
#import "Set.h"
#import "MagicalRecord+Actions.h"
#import "NSManagedObject+MagicalFinders.h"
#import "SWTestCase.h"

@interface ModelTests : SWTestCase
@end

@implementation ModelTests

- (void)testCreatingAWorkout {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Workout *workout = [Workout MR_createInContext:localContext];
        XCTAssertNotNil(workout.setGroups);

        SetGroup *setGroup = [SetGroup MR_createInContext:localContext];
        [workout addSetGroupsObject:setGroup];

        XCTAssertNotNil(setGroup.sets);

        Set *set = [Set MR_createInContext:localContext];
        set.activity = @"Bench";
        set.comments = @"Missed a rep";
        set.reps = @2;
        set.weight = [NSDecimalNumber decimalNumberWithString:@"205"];
        set.units = @"lbs";
        [setGroup addSetsObject:set];

    }                 completion:^(BOOL success, NSError *error) {
        NSArray *workouts = [Workout MR_findAll];
        XCTAssertEqual([workouts count], 1);

        Workout *workout = workouts[0];
        XCTAssertEqual([workout.setGroups count], 1);

        SetGroup *setGroup = workout.setGroups[0];
        XCTAssertEqual([setGroup.sets count], 1);

        Set *set = setGroup.sets[0];
        XCTAssertEqualObjects(set.activity, @"Bench");
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

@end