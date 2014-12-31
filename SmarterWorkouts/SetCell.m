#import "SetCell.h"
#import "UIColor+HexString.h"

@implementation SetCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.backgroundColor = [UIColor colorWithHexString:@"398BFF"];

    UIView *selectedView = [UIView new];
    [selectedView setBackgroundColor:[UIColor colorWithHexString:@"0169F9"]];
    [self setSelectedBackgroundView:selectedView];
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:1.0f];
}

@end