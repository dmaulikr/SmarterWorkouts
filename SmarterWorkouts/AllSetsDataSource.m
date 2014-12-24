#import "AllSetsDataSource.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"

@implementation AllSetsDataSource

- (instancetype)initWithWorkout:(Workout *)workout {
    self = [super init];
    if (self) {
        self.workout = workout;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.workout setGroups][0] sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
    Set *set = [self setForIndexPath:indexPath];
    [[cell textLabel] setText:set.activity];
    return cell;
}

- (Set *)setForIndexPath:(NSIndexPath *)indexPath {
    return [[self.workout setGroups][0] sets][(NSUInteger) indexPath.row];
}

+ (void)registerNibs:(UITableView *)tableView {

}

@end