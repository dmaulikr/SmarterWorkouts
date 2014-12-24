#import <MagicalRecord/MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
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
#import "ActivitySelectorInputViewController.h"
#import "HistoryViewController.h"
#import "WorkoutCopier.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SetCellFactory registerNibs:self.tableView];
    [ActivityCellFactory registerNibs:self.tableView];

    if (!self.workout) {
        self.newWorkout = YES;
        self.title = @"New Workout";
        self.workout = [self createNewWorkout];
        [self.selectActivityContainer setHidden:YES];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    else {
        self.newWorkout = NO;
        self.title = @"Edit Workout";
        [self hideInitialViews];
        [self restoreViewState];
        [self setRepeatActivityToLast:self.workout];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(doneButtonTapped:)];
    }

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (Workout *)createNewWorkout {
    Workout *workout = [Workout MR_createEntity];
    workout.date = [NSDate new];
    [workout addSetGroupsObject:[SetGroup MR_createEntity]];
    return workout;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newActivity"] || [[segue identifier] isEqualToString:@"selectActivity"]) {
        NewActivitySelectorInputViewController *controller = [segue destinationViewController];
        [controller setDelegate:self];

        if ([[segue identifier] isEqualToString:@"selectActivity"]) {
            self.selectActivityController = (ActivitySelectorInputViewController *) controller;
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

    [self hideInitialViews];
    [self.selectActivityController setLastActivity:activity];

    [self.tableView reloadData];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 300, 0)];
    [self.tableView layoutIfNeeded];
    NSIndexPath *lastIndexPath = [NSIndexPath                       indexPathForRow:
            ([self tableView:self.tableView numberOfRowsInSection:0] - 1) inSection:0];
    [self scrollToIndexPath:lastIndexPath];
    [self.tableView setScrollEnabled:NO];
}

- (void)hideInitialViews {
    [self.startNewActivityContainer setHidden:YES];
    [self.quoteContainer setHidden:YES];
    [self.selectActivityContainer setHidden:NO];
}

- (void)copyWorkout:(Workout *)workout {
    [WorkoutCopier copy:workout to:self.workout];
    [self hideInitialViews];
    [self restoreViewState];
    [self setRepeatActivityToLast:workout];
}

- (void)setRepeatActivityToLast:(Workout *)workout {
    NSString *activityName = [[[workout.setGroups[0] sets] lastObject] activity];
    Activity *lastActivity = [Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@",
                                                                                                  @"name", activityName]];
    [self.selectActivityController setRepeatActivity:lastActivity];
}

- (void)formCanceled {
    [self restoreViewState];
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
    [self restoreViewState];
}

- (void)formDelete {
    SetGroup *setGroup = self.workout.setGroups[0];
    [setGroup removeSetsObject:self.selectedSet];
    [self restoreViewState];
}

- (void)restoreViewState {
    [self.tableView setScrollEnabled:YES];
    [self resetFormState];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView reloadData];

    [self.navigationItem.rightBarButtonItem setEnabled:([[self.workout.setGroups[0] sets] count] > 0)];
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

- (IBAction)doneButtonTapped:(id)sender {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    if (self.newWorkout) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HistoryViewController" bundle:nil];
        HistoryViewController *history = [sb instantiateViewControllerWithIdentifier:@"historyViewController"];
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
        [viewControllers removeLastObject];
        [viewControllers addObject:history];
        [[self navigationController] setViewControllers:viewControllers animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end