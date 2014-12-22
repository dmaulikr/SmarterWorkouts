#import "SelectionGroupHeader.h"
#import "UIImageViewHelper.h"

@implementation SelectionGroupHeader

- (void)setType:(NSString *)type {
    if ([type isEqualToString:@"weight"]) {
        [self.typeImage setImage:[UIImage imageNamed:@"1091-weights"]];
    }
    else {
        [self.typeImage setImage:nil];
    }
    [UIImageViewHelper makeWhite:self.typeImage];

    [self.typeName setText:type];
}

@end