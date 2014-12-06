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
    if ([self isEditingSet] || [self isAddingSet]) {
        return 1;
    }
    return 2;
}

- (BOOL)isEditingSet {
    return self.selectedSet != nil;
}

- (BOOL)isAddingSet {
    return self.selectedActivity != nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }

    int rows = [[self.workout.setGroups[0] sets] count] + ([self isAddingSet] ? 1 : 0);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isEditingSet] && ![self isAddingSet] && indexPath.section == 1) {
        ActivitySelectorTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class) forIndexPath:indexPath];
        SetGroup *setGroup = self.workout.setGroups[0];
        NSUInteger setsCount = [[setGroup sets] count];
        Set *lastSet = setsCount > 0 ? [setGroup sets][setsCount - 1] : nil;
        [inputCell setActivity:[Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name", lastSet.activity]]];
        [inputCell setDelegate:self];
        return inputCell;
    }

    Set *currentSet = nil;
    if ([indexPath row] < [[self.workout.setGroups[0] sets] count]) {
        currentSet = [self.workout.setGroups[0] sets][(NSUInteger) indexPath.row];
    }

    if (([self isAddingSet] && [indexPath row] == [[self.workout.setGroups[0] sets] count]) ||
            ([self isEditingSet] && currentSet == self.selectedSet)) {
        ActivityWeightFormCell *cell = nil;
        if ([[self activityType] isEqualToString:@"weight"]) {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
            if (self.selectedActivity != nil) {
                [cell setActivity:self.selectedActivity];
            }
            if (self.selectedSet != nil) {
                [cell setSelectedSet:self.selectedSet];
            }
        }
        else if ([[self activityType] isEqualToString:@"timer"]) {
            [NSException raise:@"Something" format:@""];
        }

        [cell setActivityFormDelegate:self];
        return cell;
    }

    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetCell.class) forIndexPath:indexPath];
    [cell setSet:currentSet];
    return cell;
}

- (NSString *)activityType {
    if (self.selectedActivity) {
        return self.selectedActivity.type;
    }
    else {
        Activity *activity = [Activity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name", self.selectedSet.activity]];
        return [activity type];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:SetCell.class]) {
        SetGroup *setGroup = self.workout.setGroups[0];
        self.selectedSet = [setGroup sets][(NSUInteger) indexPath.row];
    }
    else if ([cell isKindOfClass:ActivityWeightFormCell.class]) {
        return;
    }
    else {
        self.selectedSet = nil;
    }
    [self.tableView reloadData];
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
    [setGroup removeSetsObject:self.selectedSet];
    self.selectedSet = nil;
    [self.tableView reloadData];
}


@end