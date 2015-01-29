#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Friend;

@interface FriendCell : UITableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) Friend *friend;
@end