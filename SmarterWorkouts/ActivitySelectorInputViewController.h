#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"
#import "NewActivitySelectorInputViewController.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface ActivitySelectorInputViewController : NewActivitySelectorInputViewController <UITextFieldDelegate, ActivitySelectorDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *repeatImage;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property(weak, nonatomic) IBOutlet UIButton *repeatActivityButton;
@property (weak, nonatomic) IBOutlet UILabel *repeatActivityLabel;

- (void)setRepeatActivity:(Activity *)activity;
@end
