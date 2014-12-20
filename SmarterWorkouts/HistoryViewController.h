#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WorkoutSelectionDelegate;
@class Workout;

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
}
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) Workout *selectedWorkout;
@property(nonatomic) NSObject <WorkoutSelectionDelegate> *selectionDelegate;

@end