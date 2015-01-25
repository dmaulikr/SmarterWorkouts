#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CloudKitUserService : NSObject
@property(nonatomic) CKRecordID *userID;

+ (instancetype)instance;

- (void)fetchUser:(void (^)(CKRecordID *))callback;
@end