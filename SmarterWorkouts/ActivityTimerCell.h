#import <Foundation/Foundation.h>
#import "ActivityCell.h"

@class FlavorTextUITextField;

@interface ActivityTimerCell : ActivityCell <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *seconds;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;

@property (weak, nonatomic) IBOutlet FlavorTextUITextField *minutes;
@end