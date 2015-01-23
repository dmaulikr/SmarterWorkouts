#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "SWTestCase.h"
#import "CloudKitTestCase.h"

@interface CloudKitTests : CloudKitTestCase
@end

@implementation CloudKitTests

- (void)testCreatesWorkouts {
    XCTestExpectation *expectation = [self expectationWithDescription:@"cloudkit"];
    [[CKContainer defaultContainer] fetchUserRecordIDWithCompletionHandler:^(CKRecordID *recordID, NSError *error) {
        XCTAssertNil(error, @"Not logged into iCloud");
        XCTAssertNotNil(recordID);

        CKRecord *workout = [[CKRecord alloc] initWithRecordType:@"Workout"];
        workout[@"user"] = [[CKReference alloc] initWithRecordID:recordID action:CKReferenceActionDeleteSelf];
        workout[@"date"] = [NSDate new];
        workout[@"comments"] = @"Hard workout";

        CKRecord *setGroup = [[CKRecord alloc] initWithRecordType:@"SetGroup"];
        setGroup[@"name"] = @"Set group name";
        setGroup[@"workout"] = [[CKReference alloc] initWithRecordID:workout.recordID action:CKReferenceActionDeleteSelf];
        workout[@"setGroups"] = @[[[CKReference alloc] initWithRecord:setGroup action:CKReferenceActionNone]];

        CKModifyRecordsOperation *saveRecords = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:@[workout, setGroup] recordIDsToDelete:nil];
        [saveRecords setModifyRecordsCompletionBlock:^(NSArray *savedRecords, NSArray *deletedRecordIDs, NSError *operationError) {
            XCTAssertEqual([savedRecords count], 2);
            [expectation fulfill];
        }];
        [[[CKContainer defaultContainer] publicCloudDatabase] addOperation:saveRecords];
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

- (void)testCascadesDelete {
    XCTestExpectation *expectation = [self expectationWithDescription:@"cloudkit"];
    [[CKContainer defaultContainer] fetchUserRecordIDWithCompletionHandler:^(CKRecordID *recordID, NSError *error) {
        XCTAssertNil(error, @"Not logged into iCloud");

        CKRecord *workout = [[CKRecord alloc] initWithRecordType:@"Workout"];
        workout[@"user"] = [[CKReference alloc] initWithRecordID:recordID action:CKReferenceActionDeleteSelf];
        CKRecord *setGroup = [[CKRecord alloc] initWithRecordType:@"SetGroup"];
        setGroup[@"workout"] = [[CKReference alloc] initWithRecordID:workout.recordID action:CKReferenceActionDeleteSelf];
        workout[@"setGroups"] = @[[[CKReference alloc] initWithRecord:setGroup action:CKReferenceActionNone]];

        CKModifyRecordsOperation *saveRecords = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:@[workout, setGroup] recordIDsToDelete:nil];
        CKModifyRecordsOperation *deleteRecords = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:nil recordIDsToDelete:@[workout.recordID]];

        [saveRecords setModifyRecordsCompletionBlock:^(NSArray *savedRecords, NSArray *deletedRecordIDs, NSError *operationError) {
            XCTAssertEqual([savedRecords count], 2);
            [[[CKContainer defaultContainer] publicCloudDatabase] addOperation:deleteRecords];
        }];

        [deleteRecords setModifyRecordsCompletionBlock:^(NSArray *savedRecords, NSArray *deletedRecordIDs, NSError *operationError) {
            //happens in the background. Can immediately query but is actually deleted later.
            XCTAssertEqual([deletedRecordIDs count], 1);
            [expectation fulfill];
        }];

        [[[CKContainer defaultContainer] publicCloudDatabase] addOperation:saveRecords];
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

@end