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
#import "HistoryCellExpanded.h"
#import "WorkoutController.h"

@implementation HistoryViewController {
    __weak IBOutlet UILabel *emptyLabel;
}

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
    [CellRegister registerClass:HistoryCellExpanded.class for:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self showHideEmptyLabel];
    [self.tableView reloadData];
}

- (void)showHideEmptyLabel {
    if (self.selectionDelegate) {
        [emptyLabel setText:@"No workouts. Yet."];
    }
    else {
        [emptyLabel setText:@"The secret of getting ahead is getting started."];
    }
    [emptyLabel setHidden:[self tableView:self.tableView numberOfRowsInSection:0] != 0];
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
    Workout *workout = [self findAllWorkouts][(NSUInteger) indexPath.row];

    HistoryCell *cell = nil;
    if (self.selectedWorkout == workout) {
        HistoryCellExpanded *expanded = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HistoryCellExpanded.class)];
        [expanded setDelegate:self];
        if (self.selectionDelegate) {
            [expanded.editButtonLabel setText:@"Copy"];
        }
        else {
            [expanded.editButtonLabel setText:@"Edit"];
        }
        cell = expanded;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HistoryCell.class)];
    }

    [cell setWorkout:workout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Workout *newSelectedWorkout = [self findAllWorkouts][(NSUInteger) indexPath.row];

    self.selectedWorkout = nil;

    if (self.selectedWorkout == newSelectedWorkout) {
        self.selectedWorkout = nil;
    }
    else {
        self.selectedWorkout = newSelectedWorkout;
    }
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.tableView reloadData];
}

- (void)editWorkout:(Workout *)workout {
    if (self.selectionDelegate) {
        [self.selectionDelegate workoutSelected:self.selectedWorkout];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIStoryboard *historyStoryboard = [UIStoryboard storyboardWithName:@"Workout" bundle:[NSBundle mainBundle]];
        WorkoutController *controller = [historyStoryboard instantiateInitialViewController];
        [controller setWorkout:workout];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Workout *workout = [self findAllWorkouts][(NSUInteger) indexPath.row];
        [workout MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.tableView reloadData];
        [self showHideEmptyLabel];
    }
}

@end