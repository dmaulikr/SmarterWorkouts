#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnitsChangedDelegate.h"

@interface BarPlateSetup : UIViewController <UnitsChangedDelegate> {}
@property (weak, nonatomic) IBOutlet UITextField *barTextField;

@property(nonatomic, copy) NSString *units;
@end