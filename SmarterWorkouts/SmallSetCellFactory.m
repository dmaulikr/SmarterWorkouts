#import "SetCellFactory.h"
#import "Set.h"
#import "WeightSetCell.h"
#import "DurationSetCell.h"
#import "CellRegister.h"
#import "SmallSetCellFactory.h"
#import "SmallWeightSetCell.h"
#import "SmallDurationSetCell.h"

@implementation SmallSetCellFactory

+ (void)registerNibs:(UITableView *)tableView {
    NSArray *classes = @[SmallWeightSetCell.class, SmallDurationSetCell.class];
    for (Class klass in classes) {
        [CellRegister registerClass:klass for:tableView];
    }
}

+ (UITableViewCell *)cellForSet:(Set *)set tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    SetCell *cell = nil;
    if ([set.duration intValue] > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SmallDurationSetCell.class) forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SmallWeightSetCell.class) forIndexPath:indexPath];
    }
    [cell setSet:set];
    return cell;
}

@end