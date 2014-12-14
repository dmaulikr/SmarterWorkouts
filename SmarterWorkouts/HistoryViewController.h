#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end