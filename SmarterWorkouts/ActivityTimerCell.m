#import "ActivityTimerCell.h"
#import "FlavorTextUITextField.h"

@implementation ActivityTimerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.minutes setFlavor:@"minutes"];
    [self.seconds setFlavor:@"seconds"];

    [self.minutes setDelegate:self];
    [self.seconds setDelegate:self];

    [self.minutes addTarget:self
                     action:@selector(enableDisableStartButton:)
           forControlEvents:UIControlEventEditingChanged];
    [self.seconds addTarget:self
                     action:@selector(enableDisableStartButton:)
           forControlEvents:UIControlEventEditingChanged];


    [self.startTimerButton setEnabled:NO];
    self.startTimerButton.alpha = 0.5;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.minutes setText:@""];
    [self.seconds setText:@""];
}

- (void)enableDisableStartButton:(id)textFieldDidChange {
    BOOL enableButton = ![self.minutes.text isEqualToString:@""] || ![self.seconds.text isEqualToString:@""];
    if (enableButton != self.startTimerButton.enabled) {
        [self.startTimerButton setEnabled:enableButton];
        [UIView animateWithDuration:0.5 animations:^{
            self.startTimerButton.alpha = (CGFloat) (enableButton ? 1 : 0.5);
        }];
    }
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