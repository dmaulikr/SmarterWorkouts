#import <UIKit/UIKit.h>

@interface ContextViewController : UIViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

- (CGFloat)initialHeight;

- (CGFloat)expandedHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateIn;

- (void)animateOut:(void (^)(BOOL))pFunction;

- (void)animateToHeight:(CGFloat)height;

@end