#import <UIKit/UIKit.h>

@class WorkoutController;
@protocol ActivitySelectorDelegate;

@interface ActivitySelectorTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *activityInput;
@property(nonatomic, weak) UIViewController<ActivitySelectorDelegate> *delegate;
@end