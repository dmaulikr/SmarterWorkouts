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
#import "ActivitySelectorInputViewController.h"
#import "HistoryViewController.h"
#import "WorkoutCopier.h"
#import "CurrentWorkout.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SetCellFactory registerNibs:self.tableView];
    [ActivityCellFactory registerNibs:self.tableView];

    if (!self.workout) {
        self.newWorkout = YES;
        self.title = @"New Workout";

        if ([[CurrentWorkout instance] workout]) {
            self.workout = [[CurrentWorkout instance] workout];
            self.context = [[CurrentWorkout instance] context];
            [self hideInitialViews];
            [self restoreViewState];
            [self setRepeatActivityToLast:self.workout];
        }
        else {
            self.workout = [self createNewWorkout];
            [[CurrentWorkout instance] setWorkout:self.workout];
            [[CurrentWorkout instance] setContext:self.context];
            [self.selectActivityContainer setHidden:YES];
            [self.navigationItem.rightBarButtonItem setEnabled:NO];
        }
    }
    else {
        self.context = [NSManagedObjectContext MR_defaultContext];
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
    self.context = [NSManagedObjectContext MR_context];
    Workout *workout = [Workout MR_createEntityInContext:self.context];
    workout.date = [NSDate new];
    [workout addSetGroupsObject:[SetGroup MR_createEntityInContext:self.context]];
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
        Set *setToCopy = nil;
        if (self.copyLastSet && [indexPath row] > 0) {
            setToCopy = [self.workout.setGroups[0] sets][(NSUInteger) ([indexPath row] - 1)];
        }
        ActivityWeightFormCell *cell = [ActivityCellFactory cellForSelectedActivity:self.selectedActivity
                                                                        selectedSet:self.selectedSet
                                                                          setToCopy:setToCopy
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
    [self setRepeatActivity:activity];

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
}

- (void)activityRepeated {
    self.copyLastSet = YES;
    [self activitySelected:self.repeatActivity];
    self.copyLastSet = NO;
}

- (void)copyWorkout:(Workout *)workout {
    [WorkoutCopier copy:workout to:self.workout];
    [self hideInitialViews];
    [self restoreViewState];
    [self setRepeatActivityToLast:workout];
}

- (void)setRepeatActivity:(Activity *)repeatActivity {
    _repeatActivity = repeatActivity;
    [self.selectActivityController setRepeatActivity:repeatActivity];
}

- (void)setRepeatActivityToLast:(Workout *)workout {
    if ([[workout.setGroups[0] sets] count] == 0) {
        [self setRepeatActivity:nil];
        return;
    }

    [self setRepeatActivity:[[[workout.setGroups[0] sets] lastObject] activity]];
}

- (void)formCanceled {
    [self setRepeatActivityToLast:self.workout];
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

- (void)restoreViewState {
    [self.tableView setScrollEnabled:YES];
    [self.selectActivityContainer setHidden:NO];
    [self resetFormState];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView reloadData];

    [self.navigationItem.rightBarButtonItem setEnabled:([[self.workout.setGroups[0] sets] count] > 0)];
}

- (void)formChangeToType:(NSString *)type withOptions:(NSDictionary *)options {
    if ([type isEqualToString:@"activetimer"]) {
        [self.selectActivityContainer setHidden:YES];
    }

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
    [self.context MR_saveToPersistentStoreAndWait];
    [[CurrentWorkout instance] setWorkout:nil];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SetGroup *setGroup = self.workout.setGroups[0];
        Set *set = [setGroup sets][(NSUInteger) [indexPath row]];
        [setGroup removeSetsObject:set];
        [set MR_deleteEntity];
        [self restoreViewState];
        [self setRepeatActivityToLast:self.workout];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end