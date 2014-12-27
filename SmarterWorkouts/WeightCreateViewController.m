#import "WeightCreateViewController.h"
#import "DecimalNumbers.h"

@implementation WeightCreateViewController

- (NSDictionary *)activityData {
    return @{
            @"usesBar" : @([self.usesBar isOn]),
            @"max" : [DecimalNumbers parse:self.maxField.text],
            @"units" : ([self.lbsKgSegment selectedSegmentIndex] == 0 ? @"lbs" : @"kg")
    };
}

@end