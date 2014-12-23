#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalAggregation.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "HistoryViewController.h"
#import "Workout.h"
#import "CellRegister.h"
#import "HistoryCell.h"
#import "SetGroup.h"
#import "WorkoutSelectionDelegate.h"

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History";
    [self.tableView setBackgroundColor:
            [UIColor colorWithRed:(CGFloat) (52.0 / 255) green:(CGFloat) (182 / 255.0) blue:(CGFloat) (252.0 / 255) alpha:1]];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [CellRegister registerClass:HistoryCell.class for:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.selectionDelegate) {
        UIBarButtonItem *useButton = [[UIBarButtonItem alloc] initWithTitle:@"Use" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(useButtonTapped:)];
        [useButton setEnabled:NO];
        self.navigationItem.rightBarButtonItem = useButton;
    }
}

- (void)useButtonTapped:(id)useButton {
    [self.selectionDelegate workoutSelected:self.selectedWorkout];
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedWorkout = [self findAllWorkouts][(NSUInteger) indexPath.row];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        Workout *workout = [self findAllWorkouts][(NSUInteger) indexPath.row];
        [workout MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}


@end