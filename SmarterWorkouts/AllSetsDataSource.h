#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface AllSetsDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) Workout *workout;

- (instancetype)initWithWorkout:(Workout *)workout;

+ (void)registerNibs:(UITableView *)tableView;
@end