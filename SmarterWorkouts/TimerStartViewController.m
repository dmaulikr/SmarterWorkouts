#import "ActivityTimerCell.h"
#import "FlavorTextUITextField.h"
#import "TimerStartViewController.h"

@implementation TimerStartViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.minutes setFlavor:@"minutes"];
    [self.seconds setFlavor:@"seconds"];

    [self.minutes setDelegate:self];
    [self.seconds setDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.minutes becomeFirstResponder];
}

- (IBAction)startTimer:(id)sender {

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