#import <MagicalRecord/MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "WorkoutController.h"
#import "ActivityWeightFormCell.h"
#import "Activity.h"
#import "Workout.h"
#import "SetGroup.h"
#import "ActivitySelectorTableViewCell.h"
#import "Set.h"
#import "SetCell.h"
#import "NSManagedObject+MagicalFinders.h"

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

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivitySelectorTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivityWeightFormCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivityWeightFormCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SetCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SetCell.class)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    const int ONE_FOR_ACTIVITY_SELECTOR = self.selectedSet == nil ? 1 : 0;
    return [[self.workout.setGroups[(NSUInteger) section] sets] count] + ONE_FOR_ACTIVITY_SELECTOR;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Set *currentSet = nil;
    if ([indexPath row] < [[self.workout.setGroups[0] sets] count]) {
        currentSet = [self.workout.setGroups[0] sets][(NSUInteger) indexPath.row];
    }

    if (([indexPath row] == [self tableView:tableView numberOfRowsInSection:indexPath.section] - 1 && self.selectedSet == nil)
            || (currentSet != nil && currentSet == self.selectedSet)) {
        if (!self.selectedActivity && !self.selectedSet) {
            ActivitySelectorTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class) forIndexPath:indexPath];
            SetGroup *setGroup = self.workout.setGroups[0];
            NSUInteger setsCount = [[setGroup sets] count];
            Set *lastSet = setsCount > 0 ? [setGroup sets][setsCount - 1] : nil;
            [inputCell setActivity:[Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name", lastSet.activity]]];
            [inputCell setDelegate:self];
            return inputCell;
        }

        if (self.selectedSet == nil || (currentSet != nil && currentSet == self.selectedSet)) {
            ActivityWeightFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
            [cell setWeightActivityFormDelegate:self];
            if (self.selectedActivity != nil) {
                [cell setActivity:self.selectedActivity];
            }
            if (self.selectedSet != nil) {
                [cell setSelectedSet:self.selectedSet];
            }
            return cell;
        }
    }
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetCell.class) forIndexPath:indexPath];
    [cell setSet:currentSet];
    return cell;
}

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:
        (NSIndexPath *)indexPath {
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:SetCell.class]) {
        SetGroup *setGroup = self.workout.setGroups[0];
        self.selectedSet = [setGroup sets][(NSUInteger) indexPath.row];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    else {
        self.selectedSet = nil;
        [self.tableView reloadData];
    }
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (void)activitySelected:(Activity *)activity {
    self.selectedActivity = activity;
    [self.tableView reloadData];
}

- (void)formCanceled {
    self.selectedActivity = nil;
    self.selectedSet = nil;
    [self.tableView reloadData];
}

- (void)formFinished:(NSArray *)sets {
    if (self.selectedSet) {
        SetGroup *setGroup = self.workout.setGroups[0];
        NSUInteger index = [setGroup.sets indexOfObject:self.selectedSet];
        [setGroup insertSetsArray:sets atIndex:index];
        [setGroup removeSetsObject:self.selectedSet];

        self.selectedSet = nil;
    }
    else {
        self.selectedActivity = nil;
        SetGroup *setGroup = self.workout.setGroups[0];
        [setGroup addSetsArray:sets];
    }

    [self.tableView reloadData];
}

- (void)formDelete {
    SetGroup *setGroup = self.workout.setGroups[0];
    NSUInteger index = [setGroup.sets indexOfObject:self.selectedSet];
    [setGroup removeSetsObject:self.selectedSet];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    self.selectedSet = nil;
    [self.tableView reloadData];
}


@end