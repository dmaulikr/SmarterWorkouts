#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {}
@property (weak, nonatomic) IBOutlet UILabel *textStatus;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *contactsUsingApp;
@property(nonatomic) BOOL contactsFound;
@end