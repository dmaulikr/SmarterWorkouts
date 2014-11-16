#import <UIKit/UIKit.h>

@interface PlateViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSLayoutConstraint *contextTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property(nonatomic) BOOL expanded;

- (CGFloat)initialHeight;

- (void)attachToBottomOfView:(UIView *)parentView;

- (void)animateIn;

- (void)animateOut:(void (^)(BOOL))pFunction;
@end