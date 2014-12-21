#import "WeightInputControls.h"

@implementation WeightInputControls

+ (void)addLbsKgSelector:(UITextField *)field {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"lbs", @"kg"]];
    segmentedControl.frame = CGRectMake(0, 0, 120, 36);
    segmentedControl.selectedSegmentIndex = 0;

    toolbar.items = @[
            [[UIBarButtonItem alloc] initWithCustomView:segmentedControl]
    ];
    field.inputAccessoryView = toolbar;
}

@end