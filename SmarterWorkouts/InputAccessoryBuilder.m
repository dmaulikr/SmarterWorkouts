#import <objc/objc-api.h>
#import <MacTypes.h>
#import "InputAccessoryBuilder.h"
#import "FlavorTextUITextField.h"

@implementation InputAccessoryBuilder

+ (UIView *)doneButtonAccessory:(UITextField *)textField {
    return [self addButton:UIBarButtonSystemItemDone forField:textField];
}

+ (UIView *)saveButton:(UITextField *)textField {
    return [self addButton:UIBarButtonSystemItemSave forField:textField];
}

+ (UIView *)addButton:(enum UIBarButtonSystemItem)systemItem forField:(UITextField *)textField {
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];

    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *systemButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                                  target:textField action:@selector(resignFirstResponder)];
    toolbar.items = @[flexBarButton, systemButton];
    textField.inputAccessoryView = toolbar;
    return toolbar;
}

@end