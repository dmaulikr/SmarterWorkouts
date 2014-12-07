#import "DurationSetCell.h"
#import "Set.h"
#import "DurationDisplay.h"

@implementation DurationSetCell

- (void)prepareForReuse {
    [self.activityLabel setText:@""];
    [self.durationLabel setText:@""];
}

- (void)setSet:(Set *)set {
    [super setSet:set];
    [self.activityLabel setText:set.activity];
    [self.durationLabel setText:[DurationDisplay displayHumanDurationFromSeconds:set.duration]];
}

@end