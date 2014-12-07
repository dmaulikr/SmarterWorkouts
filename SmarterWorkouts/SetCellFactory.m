#import "SetCellFactory.h"
#import "Set.h"
#import "WeightSetCell.h"
#import "DurationSetCell.h"

@implementation SetCellFactory

+ (void)registerNibs:(UITableView *)tableView {
    NSArray *classes = @[WeightSetCell.class, DurationSetCell.class];
    for (Class klass in classes) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(klass) bundle:nil]
        forCellReuseIdentifier:NSStringFromClass(klass)];
    }
}

+ (UITableViewCell *)cellForSet:(Set *)set tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    SetCell *cell = nil;
    if ([set.duration intValue] > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DurationSetCell.class) forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(WeightSetCell.class) forIndexPath:indexPath];
    }
    [cell setSet:set];
    return cell;
}

@end