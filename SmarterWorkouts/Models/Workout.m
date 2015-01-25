#import <CloudKit/CloudKit.h>
#import <objc/objc-api.h>
#import "Workout.h"
#import "SetGroup.h"
#import "CloudKitUserService.h"

@implementation Workout

@dynamic comments;
@dynamic date;
@dynamic duration;
@dynamic name;
@dynamic setGroups;

- (CKRecord *)toRecordWithParent:(CKRecordID *)user {
    CKRecord *workoutRecord = [[CKRecord alloc] initWithRecordType:@"Workout" recordID:
            [[CKRecordID alloc] initWithRecordName:[[self.objectID URIRepresentation] absoluteString]]];
    workoutRecord[@"user"] = [[CKReference alloc] initWithRecordID:user action:CKReferenceActionDeleteSelf];
    workoutRecord[@"name"] = self.name;
    workoutRecord[@"duration"] = self.duration;
    workoutRecord[@"date"] = self.date;
    workoutRecord[@"comments"] = self.comments;
    workoutRecord[@"setGroups"] = [@[] mutableCopy];
    for (SetGroup *setGroup in self.setGroups) {
        [workoutRecord[@"setGroups"] addObject:[[CKReference alloc] initWithRecord:
                [setGroup toRecordWithParent:workoutRecord.recordID]        action:CKReferenceActionNone]];
    }
    return workoutRecord;
}

- (NSArray *)allRecordsToSave:(CKRecordID *)parent {
    CKRecord *record = [self toRecordWithParent:parent];
    NSMutableArray *all = [@[record] mutableCopy];
    for (SetGroup *setGroup in self.setGroups) {
        for (CKRecord *innerRecord in [setGroup allRecordsToSave:record.recordID]) {
            [all addObject:innerRecord];
        }
    }
    return all;
}

- (void)didSave {
    [super didSave];
    [self saveToCloudKit];
}

- (void)saveToCloudKit {
    [[CloudKitUserService instance] fetchUser:^(CKRecordID *user) {
        NSArray *allRecords = [self allRecordsToSave:user];
        CKModifyRecordsOperation *saveOperation = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:allRecords recordIDsToDelete:nil];
        [saveOperation setModifyRecordsCompletionBlock:^(NSArray *savedRecords, NSArray *deletedRecordIDs, NSError *operationError) {
            if (operationError) {
                NSLog(@"ERROR SAVING");
                NSLog(@"%@", operationError);
            }
        }];
        [[[CKContainer defaultContainer] publicCloudDatabase] addOperation:saveOperation];
    }];
}

@end
