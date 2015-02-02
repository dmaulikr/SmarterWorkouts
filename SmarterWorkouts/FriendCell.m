#import "FriendCell.h"
#import "Friend.h"

@implementation FriendCell

- (void)setFriend:(Friend *)friend {
    _friend = friend;
    [self.nameLabel setText:friend.name];
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    if (friend.lastWorkoutDate) {
        [self.lastActiveDate setText:[dateFormat stringFromDate:friend.lastWorkoutDate]];
    }
    else {
        [self.lastActiveDate setText:@""];
    }

    if (friend.lastWorkoutActivity) {
        [self.primaryActivityLabel setText:friend.lastWorkoutActivity];
    }
    else {
        [self.primaryActivityLabel setText:@""];
    }

}

@end