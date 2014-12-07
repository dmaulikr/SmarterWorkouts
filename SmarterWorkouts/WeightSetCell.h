#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SetCell.h"

@class Set;

@interface WeightSetCell : SetCell

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@end