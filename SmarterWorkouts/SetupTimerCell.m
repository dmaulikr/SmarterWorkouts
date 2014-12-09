#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import "SetupTimerCell.h"
#import "FlavorTextUITextField.h"
#import "ActivityFormDelegate.h"
#import "Set.h"
#import "Activity.h"

const NSString *TIMER_SETUP_ACTIVITY = @"timer";

@implementation SetupTimerCell

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

- (void)setSelectedSet:(Set *)selectedSet {
    [super setSelectedSet:selectedSet];
    int minutes = [selectedSet.duration intValue] / 60;
    if (minutes > 0) {
        [self.minutes setText:[NSString stringWithFormat:@"%d", minutes]];
    }
    else {
        [self.minutes setText:@""];
    }

    int seconds = [selectedSet.duration intValue] % 60;
    if (seconds > 0) {
        [self.seconds setText:[NSString stringWithFormat:@"%d", seconds]];
    }
    else {
        [self.seconds setText:@""];
    }

    [self.startTimerButton setTitle:@"Save" forState:UIControlStateNormal];
}

- (void)setActivity:(Activity *)activity {
    [super setActivity:activity];
    [self.startTimerButton setTitle:@"Start Timer" forState:UIControlStateNormal];
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
        [UIView animateWithDuration:0.3 animations:^{
            self.startTimerButton.alpha = (CGFloat) (enableButton ? 1 : 0.5);
        }];
    }
}

- (IBAction)startTimer:(id)sender {
    if (self.selectedSet) {
        Set *set = [Set MR_createEntity];
        set.activity = self.selectedSet.activity;
        set.duration = @([self.minutes.text intValue] * 60 + [self.seconds.text intValue]);
        [self.activityFormDelegate formFinished:@[set]];
    }
    else {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                    settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil]];
        }

        NSDictionary *options = @{
                @"minutes" : @([self.minutes.text intValue]),
                @"seconds" : @([self.seconds.text intValue])
        };
        [self.activityFormDelegate formChangeToType:@"activetimer" withOptions:options];
    }
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