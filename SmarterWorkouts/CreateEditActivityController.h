#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Activity;
@class WeightActivityEditViewController;
@class TimeActivityEditViewController;

@interface CreateEditActivityController : UIViewController
@property(nonatomic, strong) WeightActivityEditViewController *weightController;
@property(nonatomic, strong) TimeActivityEditViewController * timerController;
@property(nonatomic, strong) Activity *activityToEdit;
@end