#import "ActivityCellFactory.h"
#import "ActivityWeightFormCell.h"
#import "SetupTimerCell.h"
#import "Activity.h"
#import "Set.h"
#import "NSManagedObject+MagicalFinders.h"
#import "TimerActiveCell.h"
#import "CellRegister.h"

@implementation ActivityCellFactory

+ (void)registerNibs:(UITableView *)tableView {
    NSArray *classes = @[TimerActiveCell.class, ActivityWeightFormCell.class, SetupTimerCell.class];
    for (Class klass in classes) {
        [CellRegister registerClass:klass for:tableView];
    }
}

+ cellForSelectedActivity:(Activity *)selectedActivity
              selectedSet:(Set *)selectedSet
           formChangeType:(NSString *)formChangeType
        formChangeOptions:(NSDictionary *)formChangeOptions
                tableView:(UITableView *)tableView
                indexPath:(NSIndexPath *)indexPath {
    ActivityWeightFormCell *cell = nil;
    NSString *type = [self activityTypeForSelectedActivity:selectedActivity selectedSet:selectedSet];
    if ([type isEqualToString:WEIGHT_ACTIVITY]) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
    }
    else if ([type isEqualToString:TIMER_SETUP_ACTIVITY]) {
        if ([formChangeType isEqualToString:TIMER_ACTIVE_ACTIVITY]) {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TimerActiveCell.class) forIndexPath:indexPath];
            [cell setFormChangeOptions:formChangeOptions];
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SetupTimerCell.class) forIndexPath:indexPath];
        }
    }
    if (selectedActivity != nil) {
        [cell setActivity:selectedActivity];
    }
    if (selectedSet != nil) {
        [cell setSelectedSet:selectedSet];
    }
    return cell;
};

+ (NSString *)activityTypeForSelectedActivity:(Activity *)selectedActivity selectedSet:(Set *)selectedSet {
    if (selectedActivity) {
        return selectedActivity.type;
    }
    else {
        Activity *activity = [Activity MR_findFirstWithPredicate:
                [NSPredicate predicateWithFormat:@"%K == %@", @"name", selectedSet.activity]];
        return [activity type];
    }
}

@end