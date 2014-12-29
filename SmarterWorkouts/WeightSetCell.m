#import "WeightSetCell.h"
#import "Set.h"
#import "Activity.h"

@implementation WeightSetCell

- (void)setSet:(Set *)set {
    [super setSet:set];
    [self.activityLabel setText:set.activity.name];
    [self.repsLabel setText:[NSString stringWithFormat:@"%@x", set.reps]];
    [self.weightLabel setText:[NSString stringWithFormat:@"%@%@", set.weight, set.units]];
}

@end