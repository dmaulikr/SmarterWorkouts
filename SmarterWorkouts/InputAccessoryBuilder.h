#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InputAccessoryBuilder : NSObject

+ (UIView *)doneButtonAccessory:(UITextField *)textField;

+ (UIView *)saveButton:(UITextField *)field;
@end