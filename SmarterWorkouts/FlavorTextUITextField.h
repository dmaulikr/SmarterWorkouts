#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlavorTextUITextField : UITextField

@property(nonatomic, strong) NSString *flavor;

- (void)addFlavor;

- (void)removeFlavor;
@end