#import <MagicalRecord/MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "WorkoutController.h"
#import "ActivityWeightFormCell.h"
#import "Activity.h"
#import "PlateViewController.h"
#import "Workout.h"
#import "SetGroup.h"
#import "ActivitySelectorTableViewCell.h"

@implementation WorkoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self.view addGestureRecognizer:tap];

    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        self.workout = [Workout MR_createEntityInContext:localContext];
        self.workout.date = [NSDate new];
        [self.workout addSetGroupsObject:[SetGroup MR_createEntity]];
    }];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivitySelectorTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ActivityWeightFormCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ActivityWeightFormCell.class)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (!self.seletedActivity) {
            ActivitySelectorTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivitySelectorTableViewCell.class) forIndexPath:indexPath];
            [inputCell setDelegate:self];
            return inputCell;
        }
        else {
            ActivityWeightFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
            [cell setWeightFormDelegate:self];
            [cell setActivity:self.seletedActivity];
            return cell;
        }
    }
    return nil;
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (void)activitySelected:(Activity *)activity {
    self.seletedActivity = activity;

    if (!self.seletedActivity) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    else {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)formCanceled {
    [self activitySelected:nil];
}

- (void)formFinished:(NSArray *)sets {
    [self activitySelected:nil];
    [self.workout.setGroups[0] addSets:[[NSOrderedSet alloc] initWithArray:sets]];
    [self.workout.managedObjectContext MR_saveOnlySelfAndWait];
}

@end