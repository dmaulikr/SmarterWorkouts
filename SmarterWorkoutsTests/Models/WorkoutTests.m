#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import <CloudKit/CloudKit.h>
#import "CloudKitTestCase.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "NSManagedObject+MagicalFinders.h"
#import "Activity.h"
#import "CloudKitUserService.h"

@interface WorkoutTests : CloudKitTestCase
@end

@implementation WorkoutTests

- (void)testGetsGraphOfRecordsToSave {
    Workout *workout = [self createWorkout];
    XCTAssertEqual([[workout allRecordsToSave:[NSNull new]] count], 3);
}

- (void)testSyncsWorkoutsToCloudKit {
    XCTestExpectation *expectation = [self expectationWithDescription:@"cloudkit"];
    Workout *workout = [self createWorkout];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    [[CloudKitUserService instance] fetchUser:^(CKRecordID *user) {
        CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Workout" predicate:
                [NSPredicate predicateWithFormat:@"user = %@",
                                                 [[CKReference alloc] initWithRecordID:user action:CKReferenceActionNone]]];
        [self waitForQuery:query
               expectation:expectation
       expectedRecordTotal:1
                queryCount:0];
    }];

    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)waitForQuery:(CKQuery *)query
         expectation:(XCTestExpectation *)expectation
 expectedRecordTotal:(int)recordTotal
          queryCount:(int)queryCount {
    if (queryCount >= 3) {
        return;
    }

    [[[CKContainer defaultContainer] publicCloudDatabase] performQuery:query inZoneWithID:nil completionHandler:^(NSArray *allRecords, NSError *findError) {
        if ([allRecords count] == recordTotal) {
            [expectation fulfill];
        }
        else {
            [NSThread sleepForTimeInterval:1];
            [self waitForQuery:query expectation:expectation expectedRecordTotal:recordTotal queryCount:queryCount + 1];
        }
    }];
}

- (Workout *)createWorkout {
    Workout *workout = [Workout MR_createEntity];
    SetGroup *setGroup = [SetGroup MR_createEntity];
    [workout addSetGroupsObject:setGroup];
    Set *set = [Set MR_createEntity];
    [setGroup addSetsObject:set];
    set.activity = [Activity MR_findFirst];
    return workout;
}

@end