#import <CloudKit/CloudKit.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import "SWTestCase.h"
#import "FriendUpdater.h"
#import "Friend.h"

@interface FriendUpdaterTests : SWTestCase
@end

@implementation FriendUpdaterTests

- (void)testUpdatesForNewWorkout {
    Friend *friend1 = [Friend MR_createEntity];
    friend1.recordName = @"testname";
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:1];
    [comps setYear:2013];
    NSCalendar *cal = [NSCalendar currentCalendar];
    CKRecord *workoutRecordFriend1 = [[CKRecord alloc] initWithRecordType:@"Workout"];
    NSDate *recordDate = [cal dateFromComponents:comps];
    XCTAssertNotNil(recordDate);

    workoutRecordFriend1[@"date"] = recordDate;
    workoutRecordFriend1[@"user"] = [[CKReference alloc] initWithRecordID:[[CKRecordID alloc] initWithRecordName:friend1.recordName]
                                                                   action:CKReferenceActionNone];
    XCTAssertNil(friend1.lastWorkoutDate);
    [FriendUpdater updateFriendsFromWorkouts:@[
            workoutRecordFriend1
    ]];
    friend1 = [friend1 MR_inContext:[NSManagedObjectContext MR_defaultContext]];
    XCTAssertEqualObjects(friend1.lastWorkoutDate, recordDate);
}

@end