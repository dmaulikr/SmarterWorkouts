#import <UIKit/UIKit.h>

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface ActivitySelectorTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repeatHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repeatSpacer;

@property (weak, nonatomic) IBOutlet UITextField *activityInput;
@property (weak, nonatomic) IBOutlet UIButton *repeatActivityButton;
@property(nonatomic, weak) UIViewController<ActivitySelectorDelegate> *delegate;

- (void)setActivity:(Activity *)activity;
@end