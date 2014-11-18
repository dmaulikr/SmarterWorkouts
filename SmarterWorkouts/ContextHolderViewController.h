#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ContextViewController;

@interface ContextHolderViewController : UIViewController
@property(nonatomic) CGRect const keyboardRect;
@property(nonatomic, strong) ContextViewController *contextController;

- (void)showContext:(NSString *)nibName;

- (void)removeContextController;

@end