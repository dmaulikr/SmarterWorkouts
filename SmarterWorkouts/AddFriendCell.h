#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddFriendCell : UITableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) CKDiscoveredUserInfo *userInfo;
@end