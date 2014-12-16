#import <objc/objc-api.h>
#import "Colors.h"

@implementation Colors

+ (UIColor *)navBarColor {
    return [UIColor colorWithRed:0.255 green:0.514 blue:0.843 alpha:1];
}

+ (UIColor *)positiveButtonHighlight {
    return [UIColor colorWithRed:0.267 green:0.616 blue:0.267 alpha:1];
}

+ (UIColor *)secondaryButtonColor {
    return [UIColor colorWithRed:0.133 green:0.655 blue:0.941 alpha:1]; /*#22a7f0*/
}

+ (UIColor *)secondaryButtonColorHighlight {
    return [UIColor colorWithRed:37.0f/255 green:116.0f/255 blue:169.0f/255 alpha:1];
}

@end