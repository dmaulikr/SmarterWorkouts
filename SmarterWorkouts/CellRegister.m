#import "CellRegister.h"

@implementation CellRegister

+ (void)registerClass:(Class)klass for:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(klass) bundle:nil]
    forCellReuseIdentifier:NSStringFromClass(klass)];
}

@end