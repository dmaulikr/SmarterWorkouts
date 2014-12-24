#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface HistoryCell : UITableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *primaryActivityName;
@property(weak, nonatomic) IBOutlet UILabel *date;

@property(nonatomic, strong) Workout *workout;

- (NSString *)formattedDateForWorkout:(Workout *)workout;

@end