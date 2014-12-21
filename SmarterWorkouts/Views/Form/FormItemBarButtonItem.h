#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FormItemBarButtonItem : UIBarButtonItem
@property(nonatomic, weak) UIView *parentView;

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action parentView:(UIView *)parentView;
@end