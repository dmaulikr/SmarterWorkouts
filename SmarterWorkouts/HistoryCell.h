#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface HistoryCell : UITableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *primaryActivityName;
@property(weak, nonatomic) IBOutlet UILabel *date;

- (void)setWorkout:(Workout *)workout;

@end