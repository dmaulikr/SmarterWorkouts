#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityCell.h"

extern const NSString *TIMER_ACTIVE_ACTIVITY;

@interface TimerActiveCell : ActivityCell {}
@property (weak, nonatomic) IBOutlet UILabel *activityName;

@end