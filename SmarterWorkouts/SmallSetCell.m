#import "SmallSetCell.h"
#import "Set.h"

@implementation SmallSetCell {
    __weak IBOutlet UILabel *activityLabel;
    __weak IBOutlet UILabel *weightLabel;
    __weak IBOutlet UILabel *repsLabel;
}

- (void)setSet:(Set *)set {
    [activityLabel setText:set.activity];
    [weightLabel setText:[NSString stringWithFormat:@"%@%@", set.weight, set.units]];
    [repsLabel setText:[NSString stringWithFormat:@"%dx", [set.reps intValue]]];
}

@end