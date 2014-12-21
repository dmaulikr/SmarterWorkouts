#import "FormItemBarButtonItem.h"

@implementation FormItemBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action 
                   parentView: (UIView *) parentView {
    self = [super initWithTitle:title style:style target:target action:action];
    if (self) {
        self.parentView = parentView;
    }

    return self;
}

@end