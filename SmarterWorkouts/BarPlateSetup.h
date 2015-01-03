#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BarPlateSetup : UIViewController {}
@property (weak, nonatomic) IBOutlet UITextField *barTextField;

@property(nonatomic, copy) NSString *units;
@end