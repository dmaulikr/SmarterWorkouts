#import <MagicalRecord/MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "WorkoutController.h"
#import "ActivityWeightFormCell.h"
#import "Activity.h"
#import "Workout.h"
#import "SetGroup.h"
#import "ActivitySelectorTableViewCell.h"
#import "Set.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self.view addGestureRecognizer:tap];

    self.workout = [Workout MR_createEntity];
    self.workout.date = [NSDate new];
    [self.workout addSetGroupsObject:[SetGroup MR_createEntity]];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivitySelectorTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivityWeightFormCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivityWeightFormCell.class)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.workout.setGroups count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int sectionCount = [self numberOfSectionsInTableView:tableView];
    if (section == sectionCount - 1) {
        return 1;
    }
    else {
        return [[self.workout.setGroups[(NSUInteger) section] sets] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int sectionCount = [self numberOfSectionsInTableView:tableView];

    if (indexPath.section == sectionCount - 1) {
        if (!self.selectedActivity) {
            ActivitySelectorTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class) forIndexPath:indexPath];
            [inputCell setDelegate:self];
            return inputCell;
        }
        else {
            ActivityWeightFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
            [cell setWeightFormDelegate:self];
            [cell setActivity:self.selectedActivity];
            return cell;
        }
    }
    else {
        Set *set = [self.workout.setGroups[(NSUInteger) indexPath.section] sets][(NSUInteger) indexPath.row];
        NSLog(@"%@", set.activity);
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"temp"];
        [cell.textLabel setText:set.activity];
        return cell;
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
    [self.tableView reloadData];
}

- (void)formFinished:(NSArray *)sets {
    self.selectedActivity = nil;

    SetGroup *setGroup = self.workout.setGroups[0];
    [setGroup addSetsArray: sets];
    [self.tableView reloadData];
}

@end