#import "SetCellFactory.h"
#import "Set.h"
#import "WeightSetCell.h"
#import "DurationSetCell.h"
#import "CellRegister.h"
#import "WeightSetCellWithComments.h"

@implementation SetCellFactory

+ (void)registerNibs:(UITableView *)tableView {
    NSArray *classes = @[
            WeightSetCell.class,
            DurationSetCell.class,
            WeightSetCellWithComments.class
    ];
    for (Class klass in classes) {
        [CellRegister registerClass:klass for:tableView];
    }
}

+ (UITableViewCell *)cellForSet:(Set *)set tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    SetCell *cell = nil;
    if ([set.duration intValue] > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DurationSetCell.class) forIndexPath:indexPath];
    }
    else {
        if (set.comments) {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WeightSetCellWithComments.class) forIndexPath:indexPath];
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WeightSetCell.class) forIndexPath:indexPath];
        }
    }
    [cell setSet:set];
    return cell;
}

@end