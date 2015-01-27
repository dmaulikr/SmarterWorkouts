#import <CloudKit/CloudKit.h>
#import "AddFriendCell.h"

@implementation AddFriendCell

- (void)setUserInfo:(CKDiscoveredUserInfo *)info {
    _userInfo = info;
    [self.nameLabel setText:[NSString stringWithFormat:@"%@ %@", info.firstName, info.lastName]];
}

@end