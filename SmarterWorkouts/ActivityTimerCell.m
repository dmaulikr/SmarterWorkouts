#import "ActivityTimerCell.h"
#import "FlavorTextUITextField.h"

@implementation ActivityTimerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.minutes setFlavor:@"minutes"];
    [self.seconds setFlavor:@"seconds"];

    [self.minutes setDelegate:self];
    [self.seconds setDelegate:self];
}

- (IBAction)startTimer:(id)sender {

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.minutes becomeFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) removeFlavor];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) addFlavor];
    }
}

@end