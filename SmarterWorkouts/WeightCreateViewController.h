#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityCreateController.h"

@interface WeightCreateViewController : UIViewController <ActivityCreateController> {}
@property (weak, nonatomic) IBOutlet UISwitch *usesBar;
@property (weak, nonatomic) IBOutlet UITextField *maxField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *lbsKgSegment;
@property(nonatomic) BOOL active;

- (void)setupInitialActivity:(Activity *)activity;

@end