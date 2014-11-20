#import "WeightInputControls.h"

@implementation WeightInputControls

+ (void)setup:(UITextField *)field {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"lbs", @"kg"]];
    segmentedControl.frame = CGRectMake(0, 0, 120, 36);
    segmentedControl.selectedSegmentIndex = 0;

    toolbar.items = @[
            [[UIBarButtonItem alloc] initWithCustomView:segmentedControl],
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
            [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                             style:UIBarButtonItemStyleDone
                                            target:field
                                            action:@selector(resignFirstResponder)]
    ];
    field.inputAccessoryView = toolbar;
}

@end