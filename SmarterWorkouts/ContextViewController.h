#import <UIKit/UIKit.h>

@interface ContextViewController : UIViewController <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

- (CGFloat)initialHeight;

- (CGFloat)expandedHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateOut:(void (^)(BOOL))pFunction;

- (void)animateToHeight:(CGFloat)height;

- (void)adjustBottomConstraintForKeyboard:(CGRect)rect;

- (void)animateInWithKeyboard:(struct CGRect const)aConst;
@end