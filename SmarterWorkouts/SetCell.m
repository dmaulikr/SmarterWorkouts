#import "SetCell.h"
#import "Set.h"

@implementation SetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [UIView new];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:1/255.0f green:105/255.0f blue:249/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
}

@end