#import "PlateCell.h"
#import "FlavorTextUITextField.h"
#import "Plate.h"
#import "PlateCellProtocol.h"

@implementation PlateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.platesField setFlavor:@"plates"];
    [self.platesField setDelegate:self];
}

- (void)setPlate:(Plate *)plate {
    _plate = plate;
    [self.platesField setText:[plate.count stringValue]];
    [self.weightLabel setText:[NSString stringWithFormat:@"%@ %@", plate.weight, plate.units]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate plateBeganEditing:self.plate];
}

@end