#import <CloudKit/CloudKit.h>
#import "CloudKitUserService.h"

@implementation CloudKitUserService

+ (instancetype)instance {
    static CloudKitUserService *service = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        service = [CloudKitUserService new];
    });

    return service;
}

- (void)fetchUser:(void (^)(CKRecordID *))callback {
    if (self.userID) {
        callback(self.userID);
        return;
    }
    [[CKContainer defaultContainer] fetchUserRecordIDWithCompletionHandler:^(CKRecordID *recordID, NSError *error) {
        self.userID = recordID;
        callback(recordID);
    }];
};

@end