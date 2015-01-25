#import <Foundation/Foundation.h>

@class CKRecord;
@class CKRecordID;

@protocol CloudKitModel <NSObject>

- (CKRecord *)toRecordWithParent:(CKRecordID *)parent;

- (NSArray *)allRecordsToSave:(CKRecordID *)parent;

@end