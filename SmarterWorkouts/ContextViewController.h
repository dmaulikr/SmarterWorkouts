#import <UIKit/UIKit.h>

@interface ContextViewController : UIViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property(nonatomic) CGFloat keyboardHeight;

- (CGFloat)initialHeight;

- (CGFloat)expandedHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateToHeight:(CGFloat)height;

- (void)animateIn;

- (void)adjustBottomConstraintForKeyboard:(CGRect)rect;

@end