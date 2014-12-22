#import "SelectionGroupHeader.h"
#import "UIImageViewHelper.h"

@implementation SelectionGroupHeader

- (void)setType:(NSString *)type {
    if ([type isEqualToString:@"weight"]) {
        [self.typeImage setImage:[UIImage imageNamed:@"1091-weights"]];
    }
    else if ([type isEqualToString:@"timer"]) {
        [self.typeImage setImage:[UIImage imageNamed:@"1097-timer-2"]];
    }
    else {
        [self.typeImage setImage:nil];
    }
    [UIImageViewHelper makeWhite:self.typeImage];

    [self.typeName setText:type];
}

@end