#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddFriendViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *findingFriendsLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *findingFriendsActivityIndicator;
@property(nonatomic, strong) NSArray *contactsUsingApp;
@end