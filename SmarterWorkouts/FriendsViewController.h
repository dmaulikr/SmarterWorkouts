#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
}
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@end