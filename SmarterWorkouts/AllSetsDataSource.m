#import "AllSetsDataSource.h"
#import "Workout.h"
#import "SetGroup.h"
#import "Set.h"
#import "CellRegister.h"
#import "SmallSetCell.h"

@implementation AllSetsDataSource

- (instancetype)initWithWorkout:(Workout *)workout tableView: (UITableView *)tableView {
    self = [super init];
    if (self) {
        self.workout = workout;

        [AllSetsDataSource registerNibs:tableView];
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
    SmallSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SmallSetCell.class)];
    Set *set = [self setForIndexPath:indexPath];
    [cell setSet:set];
    return cell;
}

- (Set *)setForIndexPath:(NSIndexPath *)indexPath {
    return [[self.workout setGroups][0] sets][(NSUInteger) indexPath.row];
}

+ (void)registerNibs:(UITableView *)tableView {
    [CellRegister registerClass:SmallSetCell.class for:tableView];
}

@end