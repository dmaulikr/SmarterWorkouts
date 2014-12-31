#import "WorkoutControls.h"

@implementation WorkoutControls

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.arrangeButton setTitleColor:
                    [UIColor colorWithRed:(CGFloat) (255.0 / 255.0) green:(CGFloat) (174 / 255.0) blue:(CGFloat) (38 / 255.0) alpha:1]
                             forState:UIControlStateHighlighted];
}

@end