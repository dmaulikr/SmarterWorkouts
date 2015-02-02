#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Friend;

@interface FriendCell : UITableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActiveDate;
@property (weak, nonatomic) IBOutlet UILabel *primaryActivityLabel;
@property(nonatomic, strong) Friend *friend;
@end