#import <Foundation/Foundation.h>
#import "SetCell.h"

@interface DurationSetCell : SetCell {}
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end