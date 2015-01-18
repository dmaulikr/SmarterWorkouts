#import "WeightCreateViewController.h"
#import "DecimalNumbers.h"
#import "Activity.h"

@implementation WeightCreateViewController

- (void)addExtraInfo:(Activity *)activity {
    activity.usesBar = [self.usesBar isOn];
    activity.personalRecord = [DecimalNumbers parse:self.maxField.text];
    activity.units = [self.lbsKgSegment selectedSegmentIndex] == 0 ? @"lbs" : @"kg";
    activity.type = @"weight";
}

- (void)setupInitialActivity:(Activity *)activity {
    [self.view setHidden:activity == nil || ![activity.type isEqualToString:(NSString *) ACTIVITY_WEIGHT]];
}

@end