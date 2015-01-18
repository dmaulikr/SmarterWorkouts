#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Activity;
@class WeightCreateViewController;

@interface CreateEditActivityController : UIViewController
@property(nonatomic, strong) WeightCreateViewController *weightController;
@property(nonatomic, strong) Activity *activityToEdit;
@end