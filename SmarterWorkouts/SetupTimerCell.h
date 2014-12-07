#import <Foundation/Foundation.h>
#import "ActivityCell.h"

@class FlavorTextUITextField;

extern const NSString *TIMER_SETUP_ACTIVITY;

@interface SetupTimerCell : ActivityCell <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *seconds;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;

@property (weak, nonatomic) IBOutlet FlavorTextUITextField *minutes;
@end