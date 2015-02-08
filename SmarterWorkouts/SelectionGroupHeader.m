#import "SelectionGroupHeader.h"
#import "UIImageViewHelper.h"

@implementation SelectionGroupHeader

- (void)setType:(NSString *)type {
    NSDictionary *typesToImages = @{
            @"weight" : @"1091-weights",
            @"timer" : @"1097-timer-2",
            @"miscellaneous" : @"710-folder"
    };
    [self.typeImage setImage:[UIImage imageNamed:typesToImages[type]]];
    [UIImageViewHelper makeWhite:self.typeImage];
    [self.typeName setText:type];
}

@end