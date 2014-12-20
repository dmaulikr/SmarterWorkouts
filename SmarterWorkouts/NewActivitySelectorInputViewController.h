#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"
#import "WorkoutSelectionDelegate.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface NewActivitySelectorInputViewController : UIViewController <UITextFieldDelegate, WorkoutSelectionDelegate>
@property(weak, nonatomic) IBOutlet UIButton *findNewActivityButton;
@property (weak, nonatomic) IBOutlet UIImageView *historyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseActivityImageView;

@property (weak, nonatomic) IBOutlet UIButton *cpyAWorkoutButton;
@property(nonatomic, weak) UIViewController <ActivitySelectorDelegate> *delegate;

@end
