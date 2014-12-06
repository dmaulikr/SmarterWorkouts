#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlavorTextUITextField;

@interface TimerStartViewController : UIViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *seconds;
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *minutes;
@end