#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "PrimaryActivityFinder.h"
#import "Activity.h"

@interface PrimaryActivityFinderTests : SWTestCase
@end

@implementation PrimaryActivityFinderTests

- (void)testFindsPrimaryActivityInWorkout {
    Workout *workout = [Workout MR_createEntity];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    [self addActivity:[Activity findByName:@"Squat"] in:workout];
    [self addActivity:[Activity findByName:@"Squat"] in:workout];
    [self addActivity:[Activity findByName:@"Rest"] in:workout];
    NSString *activity = [PrimaryActivityFinder primaryActivityFor:workout];
    XCTAssertEqualObjects(activity, @"Squat");
}

- (void)testUsesFirstActivityIfNoMajority {
    Workout *workout = [Workout MR_createEntity];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    [self addActivity:[Activity findByName:@"Bench"] in:workout];
    [self addActivity:[Activity findByName:@"Squat"] in:workout];
    [self addActivity:[Activity findByName:@"Rest"] in:workout];
    NSString *activity = [PrimaryActivityFinder primaryActivityFor:workout];
    XCTAssertEqualObjects(activity, @"Bench");
}

- (void)addActivity:(Activity *)activity in:(Workout *)workout {
    Set *set = [Set MR_createEntity];
    set.activity = activity;
    [workout.setGroups[0] addSetsObject:set];
}

@end