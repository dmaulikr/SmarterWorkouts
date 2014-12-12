#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface ActivitySelectorInputViewController : UIViewController <UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet UIButton *findNewActivityButton;
@property(nonatomic, weak) UIViewController <ActivitySelectorDelegate> *delegate;
@end
