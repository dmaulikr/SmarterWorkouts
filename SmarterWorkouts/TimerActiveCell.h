#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityCell.h"
#import "TimerObserver.h"

extern const NSString *TIMER_ACTIVE_ACTIVITY;

@interface TimerActiveCell : ActivityCell <TimerObserver> {}
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property(nonatomic) int totalSeconds;
@end