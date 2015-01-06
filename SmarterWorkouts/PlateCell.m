#import "PlateCell.h"
#import "FlavorTextUITextField.h"
#import "Plate.h"
#import "PlateCellProtocol.h"
#import "DecimalNumbers.h"
#import "InputAccessoryBuilder.h"

@implementation PlateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.platesField setFlavor:@"plates"];
    [self.platesField setDelegate:self];
    [self.weightField setDelegate:self];

    [InputAccessoryBuilder saveButton:self.platesField];
    [InputAccessoryBuilder saveButton:self.weightField];
}

- (void)setPlate:(Plate *)plate {
    _plate = plate;
    [self.weightField setFlavor:plate.units];
    [self.platesField setText:[plate.count stringValue]];
    [self.weightField setText:[plate.weight stringValue]];
    [self.weightField addFlavor];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [(FlavorTextUITextField *) textField removeFlavor];
    [self.delegate plateBeganEditing:self.plate];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [(FlavorTextUITextField *) textField addFlavor];
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightField text]];
    int count = [[self.platesField text] intValue];
    self.plate.weight = weight;
    self.plate.count = @(count);
    [self.delegate plateEndEditing:self.plate];
}


@end