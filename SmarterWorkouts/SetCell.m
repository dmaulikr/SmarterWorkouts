#import "SetCell.h"
#import "Set.h"

@implementation SetCell

- (void)setSet:(Set *)set {
    _set = set;
    [self.activityLabel setText:set.activity];
    [self.repsLabel setText:[NSString stringWithFormat:@"%@x", set.reps]];
    [self.weightLabel setText:[NSString stringWithFormat:@"%@%@", set.weight, set.units]];
}

@end