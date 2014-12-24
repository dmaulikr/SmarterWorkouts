#import "AllSetsDataSource.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "SmallSetCellFactory.h"

@implementation AllSetsDataSource

- (instancetype)initWithWorkout:(Workout *)workout tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.workout = workout;

        [SmallSetCellFactory registerNibs:tableView];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        tableView.rowHeight = 27;
    }

    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.workout setGroups][0] sets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Set *set = [self setForIndexPath:indexPath];
    return [SmallSetCellFactory cellForSet:set tableView:tableView indexPath:indexPath];
}

- (Set *)setForIndexPath:(NSIndexPath *)indexPath {
    return [[self.workout setGroups][0] sets][(NSUInteger) indexPath.row];
}

@end