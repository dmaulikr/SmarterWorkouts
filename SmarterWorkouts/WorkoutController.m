#import <MagicalRecord/MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "WorkoutController.h"
#import "ActivityWeightFormCell.h"
#import "Activity.h"
#import "Workout.h"
#import "SetGroup.h"
#import "NewActivitySelectorInputViewController.h"
#import "Set.h"
#import "WeightSetCell.h"
#import "ActivityCellFactory.h"
#import "SetCellFactory.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

    self.workout = [Workout MR_createEntity];
    self.workout.date = [NSDate new];
    [self.workout addSetGroupsObject:[SetGroup MR_createEntity]];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];

    [SetCellFactory registerNibs:self.tableView];
    [ActivityCellFactory registerNibs:self.tableView];

    [self.selectActivityContainer setHidden:YES];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newActivity"] || [[segue identifier] isEqualToString:@"selectActivity"]) {
        NewActivitySelectorInputViewController *controller = [segue destinationViewController];
        [controller setDelegate:self];

        if ([[segue identifier] isEqualToString:@"selectActivity"]) {
            self.selectActivityController = controller;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)isEditingSet {
    return self.selectedSet != nil;
}

- (BOOL)isAddingSet {
    return self.selectedActivity != nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.workout.setGroups[0] sets] count] + ([self isAddingSet] ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Set *currentSet = nil;
    if ([indexPath row] < [[self.workout.setGroups[0] sets] count]) {
        currentSet = [self.workout.setGroups[0] sets][(NSUInteger) indexPath.row];
    }

    if (([self isAddingSet] && [indexPath row] == [[self.workout.setGroups[0] sets] count]) ||
            ([self isEditingSet] && currentSet == self.selectedSet)) {
        ActivityWeightFormCell *cell = [ActivityCellFactory cellForSelectedActivity:self.selectedActivity
                                                                        selectedSet:self.selectedSet
                                                                     formChangeType:self.formChangeType
                                                                  formChangeOptions:self.formChangeOptions
                                                                          tableView:tableView
                                                                          indexPath:indexPath];
        [cell setActivityFormDelegate:self];
        return cell;
    }

    return [SetCellFactory cellForSet:currentSet tableView:tableView indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:SetCell.class]) {
        SetGroup *setGroup = self.workout.setGroups[0];
        self.selectedSet = [setGroup sets][(NSUInteger) indexPath.row];
        self.selectedActivity = nil;
    }
    else if ([cell isKindOfClass:ActivityCell.class]) {
        return;
    }
    else {
        self.selectedSet = nil;
    }
    CGPoint contentOffset = [self.tableView contentOffset];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    [self.tableView setContentOffset:contentOffset animated:NO];
    [self scrollToIndexPath:indexPath];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath {
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:indexPath];
    [self.tableView setContentOffset:CGPointMake(0, cellFrame.origin.y) animated:YES];
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (void)activitySelected:(Activity *)activity {
    self.selectedActivity = activity;
    self.selectedSet = nil;

    [self.startNewActivityContainer setHidden:YES];
    [self.selectActivityContainer setHidden:NO];
    [self.quoteContainer setHidden:YES];
    [self.selectActivityController setLastActivity:activity];

    [self.tableView reloadData];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 350, 0)];
    [self.tableView layoutIfNeeded];
    NSIndexPath *lastIndexPath = [NSIndexPath                       indexPathForRow:
            ([self tableView:self.tableView numberOfRowsInSection:0] - 1) inSection:0];
    [self scrollToIndexPath:lastIndexPath];
}

- (void)formCanceled {
    [self resetFormState];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView reloadData];
}

- (void)formFinished:(NSArray *)sets {
    if (self.selectedSet) {
        SetGroup *setGroup = self.workout.setGroups[0];
        NSUInteger index = [setGroup.sets indexOfObject:self.selectedSet];
        [setGroup insertSetsArray:sets atIndex:index];
        [setGroup removeSetsObject:self.selectedSet];
    }
    else {
        SetGroup *setGroup = self.workout.setGroups[0];
        [setGroup addSetsArray:sets];
    }

    [self resetFormState];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView reloadData];
}

- (void)formDelete {
    SetGroup *setGroup = self.workout.setGroups[0];
    [setGroup removeSetsObject:self.selectedSet];
    [self resetFormState];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView reloadData];
}

- (void)formChangeToType:(NSString *)type withOptions:(NSDictionary *)options {
    self.formChangeType = type;
    self.formChangeOptions = options;
    [self.tableView reloadData];
}

- (void)resetFormState {
    self.selectedActivity = nil;
    self.selectedSet = nil;
    self.formChangeType = nil;
    self.formChangeOptions = nil;
}

@end