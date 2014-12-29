#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SWTestCase.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "NSManagedObject+MagicalDataImport.h"
#import "WorkoutCopier.h"
#import "Activity.h"

@interface WorkoutCopierTests : SWTestCase
@end

@implementation WorkoutCopierTests

- (void)testCopiesWorkouts {
    Workout *src = [Workout MR_createEntity];
    src.date = [NSDate new];
    [src addSetGroupsObject:[SetGroup MR_createEntity]];

    Set *set1 = [Set MR_createEntity];
    set1.activity = [Activity findByName:@"Squat"];
    set1.reps = @3;
    set1.units = @"lbs";
    set1.weight = [NSDecimalNumber decimalNumberWithString:@"145.5"];

    Set *set2 = [Set MR_createEntity];
    set2.activity = [Activity findByName:@"Rest"];
    set2.duration = @300;

    [src.setGroups[0] addSetsObject:set1];
    [src.setGroups[0] addSetsObject:set2];

    Workout *dest = [Workout MR_createEntity];
    [dest addSetGroupsObject:[SetGroup MR_createEntity]];
    [WorkoutCopier copy:src to:dest];
    NSOrderedSet *sets = [dest.setGroups[0] sets];
    XCTAssertEqual([sets count], 2);
    XCTAssertEqualObjects([[sets[0] activity] name], @"Squat");
    XCTAssertEqualObjects([[sets[1] activity] name], @"Rest");
}

@end