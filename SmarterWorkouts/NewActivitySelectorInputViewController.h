#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface NewActivitySelectorInputViewController : UIViewController <UITextFieldDelegate, ActivitySelectorDelegate>
@property(weak, nonatomic) IBOutlet UIButton *findNewActivityButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatActivityButton;
@property(nonatomic, weak) UIViewController <ActivitySelectorDelegate> *delegate;

@end
