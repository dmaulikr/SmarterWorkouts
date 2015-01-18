#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityCreateController.h"

@interface WeightActivityEditViewController : ActivityCreateController {}
@property (weak, nonatomic) IBOutlet UISwitch *usesBar;
@property (weak, nonatomic) IBOutlet UITextField *maxField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *lbsKgSegment;

- (void)setupInitialActivity:(Activity *)activity;

@end