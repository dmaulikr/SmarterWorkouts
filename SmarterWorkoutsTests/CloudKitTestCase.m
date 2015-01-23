#import <CloudKit/CloudKit.h>
#import "SWTestCase.h"
#import "CloudKitTestCase.h"

@implementation CloudKitTestCase

- (void)setUp {
    [super setUp];

    __block BOOL finished = NO;
    [[CKContainer defaultContainer] fetchUserRecordIDWithCompletionHandler:^(CKRecordID *recordID, NSError *error) {
        XCTAssertNotNil(recordID);
        CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Workout" predicate:[NSPredicate predicateWithFormat:@"user = %@",
                        [[CKReference alloc] initWithRecordID:recordID action:nil]]];
        [[[CKContainer defaultContainer] publicCloudDatabase] performQuery:query inZoneWithID:nil completionHandler:^(NSArray *allTestRecords, NSError *findError) {
            NSLog(@"Deleting: %d workout records", [allTestRecords count]);
            NSMutableArray *recordIds = [@[] mutableCopy];
            for (CKRecord *record in allTestRecords) {
                [recordIds addObject:record.recordID];
            }
            CKModifyRecordsOperation *deleteAllRecords = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:nil recordIDsToDelete:recordIds];
            [deleteAllRecords setModifyRecordsCompletionBlock:^(NSArray *savedRecords, NSArray *deletedRecordIDs, NSError *operationError) {
                finished = YES;
            }];
            [[[CKContainer defaultContainer] publicCloudDatabase] addOperation:deleteAllRecords];
        }];
    }];

    while (!finished) {
        [NSThread sleepForTimeInterval:0.1f];
    }
}

@end