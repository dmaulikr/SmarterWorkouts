#import "ActivityCellFactory.h"
#import "ActivityWeightFormCell.h"
#import "SetupTimerCell.h"
#import "Activity.h"
#import "Set.h"
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
                setToCopy:(Set *)setToCopy
           formChangeType:(NSString *)formChangeType
        formChangeOptions:(NSDictionary *)formChangeOptions
                tableView:(UITableView *)tableView
                indexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = nil;
    NSString *type = [self activityTypeForSelectedActivity:selectedActivity selectedSet:selectedSet];
    if ([type isEqualToString:(NSString *) WEIGHT_ACTIVITY]) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ActivityWeightFormCell.class) forIndexPath:indexPath];
    }
    else if ([type isEqualToString:(NSString *) TIMER_SETUP_ACTIVITY]) {
        if ([formChangeType isEqualToString:(NSString *) TIMER_ACTIVE_ACTIVITY]) {
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
    if (setToCopy != nil) {
        [cell setSetToCopy:setToCopy];
    }
    return cell;
};

+ (NSString *)activityTypeForSelectedActivity:(Activity *)selectedActivity selectedSet:(Set *)selectedSet {
    if (selectedActivity) {
        return selectedActivity.type;
    }
    else {
        return selectedSet.activity.type;
    }
}

@end