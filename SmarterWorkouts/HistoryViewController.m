#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "HistoryViewController.h"
#import "Workout.h"
#import "CellRegister.h"
#import "HistoryCell.h"
#import "SetGroup.h"

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History";

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [CellRegister registerClass:HistoryCell.class for:self.tableView];

    NSLog(@"%d", [Workout MR_countOfEntities]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self findAllWorkouts] count];
}

- (NSArray *)findAllWorkouts {
    return [[Workout MR_findAllSortedBy:@"date" ascending:NO] filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(Workout *workout, NSDictionary *bindings) {
                return [[workout.setGroups[0] sets] count] > 0;
            }]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HistoryCell.class)];
    Workout *workout = [self findAllWorkouts][(NSUInteger) indexPath.row];
    [cell setWorkout:workout];
    return cell;
}


@end