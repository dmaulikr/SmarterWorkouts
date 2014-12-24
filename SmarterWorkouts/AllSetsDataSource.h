#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface AllSetsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) Workout *workout;

- (instancetype)initWithWorkout:(Workout *)workout tableView:(UITableView *)tableView;

@end