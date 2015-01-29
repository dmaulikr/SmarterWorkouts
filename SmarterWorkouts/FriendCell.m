#import "FriendCell.h"
#import "Friend.h"

@implementation FriendCell

- (void)setFriend:(Friend *)friend {
    _friend = friend;
    [self.nameLabel setText:friend.name];
}

@end