#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WorkoutControlsDelegate;

@interface WorkoutControls : UIView {}
@property (weak, nonatomic) IBOutlet UIButton *arrangeButton;

@property(nonatomic) BOOL ordering;
@property(nonatomic, weak) NSObject<WorkoutControlsDelegate> *delegate;
@end