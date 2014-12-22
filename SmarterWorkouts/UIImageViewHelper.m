#import "UIImageViewHelper.h"

@implementation UIImageViewHelper

+ (void)makeWhite:(UIImageView *)imageView {
    if (imageView == nil) {
        return;
    }

    imageView.tintColor = [UIColor whiteColor];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end