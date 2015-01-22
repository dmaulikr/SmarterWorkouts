#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "SWTestCase.h"

@interface CloudKitTests : SWTestCase
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

        [[[CKContainer defaultContainer] publicCloudDatabase] saveRecord:workout completionHandler:
                ^(CKRecord *savedWorkout, NSError *saveError) {
                    XCTAssertTrue([savedWorkout.allKeys containsObject:@"user"]);

                    CKRecord *setGroup = [[CKRecord alloc] initWithRecordType:@"SetGroup"];
                    setGroup[@"name"] = @"Set group name";
                    [[[CKContainer defaultContainer] publicCloudDatabase] saveRecord:setGroup completionHandler:
                            ^(CKRecord *savedSetGroup, NSError *setGroupError) {
                                workout[@"setGroups"] = @[[[CKReference alloc] initWithRecord:savedSetGroup action:CKReferenceActionNone]];
                                [[[CKContainer defaultContainer] publicCloudDatabase] saveRecord:workout completionHandler:
                                        ^(CKRecord *savedWorkout2, NSError *savedWorkout2Error) {
                                            XCTAssertTrue([savedWorkout2.allKeys containsObject:@"SetGroups"]);
                                            [expectation fulfill];
                                        }];
                                [expectation fulfill];
                            }];
                }];
    }];

    [self waitForExpectationsWithTimeout:3 handler:^(NSError *error) {
    }];
}

@end