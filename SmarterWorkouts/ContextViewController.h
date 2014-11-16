#import <UIKit/UIKit.h>

@interface ContextViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property(nonatomic) BOOL expanded;

- (CGFloat)initialHeight;

- (CGFloat)expandedHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateIn;

- (void)animateOut:(void (^)(BOOL))pFunction;

@end