#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Activity;

@interface ActivityCreateController : UIViewController

- (void) addExtraInfo: (Activity *) activity;

- (void)setupInitialActivity:(Activity *)activity;

@property(nonatomic) BOOL active;

@end