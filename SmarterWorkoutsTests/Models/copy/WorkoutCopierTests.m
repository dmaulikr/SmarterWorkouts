#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "WorkoutCopier.h"

@interface WorkoutCopierTests : SWTestCase
@end

@implementation WorkoutCopierTests

- (void)testCopiesWorkouts {
    Workout *src = [Workout MR_createEntity];
    src.date = [NSDate new];
    [src addSetGroupsObject:[SetGroup MR_createEntity]];
    [src.setGroups[0] addSetsArray:[Set MR_importFromArray:@[
            @{
                    @"activity" : @"Squat",
                    @"reps" : @(3),
                    @"units" : @"lbs",
                    @"weight" : @(145.5)
            },
            @{
                    @"activity" : @"Rest",
                    @"duration" : @(300)
            }
    ]]];

    Workout *dest = [Workout MR_createEntity];
    [dest addSetGroupsObject:[SetGroup MR_createEntity]];
    [WorkoutCopier copy:src to:dest];
    NSOrderedSet *sets = [dest.setGroups[0] sets];
    XCTAssertEqual([sets count], 2);
    XCTAssertEqual([sets[0] activity], @"Squat");
    XCTAssertEqual([sets[1] activity], @"Rest");
}

@end