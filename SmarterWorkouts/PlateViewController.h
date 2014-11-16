#import <UIKit/UIKit.h>

@interface PlateViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

- (CGFloat)initialHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateIn;

- (void)animateOut:(void (^)(BOOL))pFunction;
@end