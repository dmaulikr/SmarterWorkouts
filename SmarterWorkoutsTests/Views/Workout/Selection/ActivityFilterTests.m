#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SWTestCase.h"
#import "ActivityFilter.h"
#import "MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "Activity.h"
#import "NSManagedObject+MagicalFinders.h"
#import "NSManagedObject+MagicalRecord.h"

@interface ActivityFilterTests : SWTestCase
@end

@implementation ActivityFilterTests

- (void)testFiltersActivitiesByName {
    NSArray *filtered = [ActivityFilter filter:[self createActivities:@[@"Bench", @"Squat", @"Rest", @"Deadlift", @"Front squat"]] forText:@"Squ"];
    XCTAssertEqual([filtered count], 2);

    Activity *found1 = filtered[0];
    Activity *found2 = filtered[1];

    XCTAssertEqualObjects(found1.name, @"Front squat");
    XCTAssertEqualObjects(found2.name, @"Squat");
}

- (void)testReturnsAllActivitiesForNoFilter {
    NSArray *filtered = [ActivityFilter filter:[self createActivities:@[@"Bench", @"Squat", @"Deadlift"]] forText:@""];
    XCTAssertEqual([filtered count], 3);
}

- (NSArray *)createActivities:(NSArray *)activityNames {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Activity MR_truncateAllInContext:localContext];
        for (NSString *name in activityNames) {
            Activity *activity = [Activity MR_createEntityInContext:localContext];
            activity.name = name;
        }
    }];
    return [Activity MR_findAllSortedBy:@"name" ascending:YES];
}

@end