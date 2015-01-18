#import "WeightActivityEditViewController.h"
#import "DecimalNumbers.h"
#import "Activity.h"

@implementation WeightActivityEditViewController

- (void)addExtraInfo:(Activity *)activity {
    activity.usesBar = [self.usesBar isOn];
    activity.personalRecord = [DecimalNumbers parse:self.maxField.text];
    activity.units = [self.lbsKgSegment selectedSegmentIndex] == 0 ? @"lbs" : @"kg";
    activity.type = @"weight";
}

- (void)setupInitialActivity:(Activity *)activity {
    [self.view setHidden:activity == nil];
    if ([activity.type isEqualToString:(NSString *) ACTIVITY_WEIGHT]) {
        [self.usesBar setOn:activity.usesBar];
        [self.maxField setText:[activity.personalRecord stringValue]];
        [self.lbsKgSegment setSelectedSegmentIndex:[activity.units isEqualToString:@"lbs"] ? 0 : 1];
    }
    else {
        [self.view setHidden:YES];
    }
}

@end