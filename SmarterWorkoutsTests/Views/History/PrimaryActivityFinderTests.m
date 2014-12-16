#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "PrimaryActivityFinder.h"

@interface PrimaryActivityFinderTests : SWTestCase
@end

@implementation PrimaryActivityFinderTests

- (void)testFindsPrimaryActivityInWorkout {
    Workout *workout = [Workout MR_createEntity];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    [self addActivity:@"Squat" in:workout];
    [self addActivity:@"Squat" in:workout];
    [self addActivity:@"Rest" in:workout];
    NSString *activity = [PrimaryActivityFinder primaryActivityFor:workout];
    XCTAssertEqual(activity, @"Squat");
}

- (void)testUsesFirstActivityIfNoMajority {
    Workout *workout = [Workout MR_createEntity];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    [self addActivity:@"Bench" in:workout];
    [self addActivity:@"Squat" in:workout];
    [self addActivity:@"Rest" in:workout];
    NSString *activity = [PrimaryActivityFinder primaryActivityFor:workout];
    XCTAssertEqual(activity, @"Bench");
}

- (void)addActivity:(NSString *)activity in:(Workout *)workout {
    Set *set = [Set MR_createEntity];
    set.activity = activity;
    [workout.setGroups[0] addSetsObject:set];
}

@end