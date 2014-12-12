#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface ActivitySelectorTableViewCell : UITableViewCell <UITextFieldDelegate, ActivitySelectorDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repeatHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repeatSpacer;

@property (weak, nonatomic) IBOutlet UIButton *findNewActivityButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatActivityButton;
@property(nonatomic, weak) UIViewController<ActivitySelectorDelegate> *delegate;

@property(nonatomic, strong) Activity *repeatActivity;

- (void)setActivity:(Activity *)activity;
@end