#import "LbsKgMenuItem.h"
#import "UnitsChangedDelegate.h"

@implementation LbsKgMenuItem

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.selectedUnits = @"lbs";
}

- (IBAction)tapped:(id)sender {
    self.selectedUnits = [self.selectedUnits isEqualToString:@"lbs"] ? @"kg" : @"lbs";
    [self.delegate unitsChanged:self.selectedUnits];
}

- (void)setSelectedUnits:(NSString *)selectedUnits {
    _selectedUnits = [selectedUnits mutableCopy];
    if ([self.selectedUnits isEqualToString:@"kg"]) {
        [self makeBold:self.kgLabel];
        [self makeLight:self.lbsLabel];
    }
    else {
        [self makeBold:self.lbsLabel];
        [self makeLight:self.kgLabel];
    }
}

- (void)makeLight:(UILabel *)label {
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f];
}

- (void)makeBold:(UILabel *)label {
    label.font =
            [UIFont                                               fontWithDescriptor:[[label.font fontDescriptor]
                    fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:label.font.pointSize];
}

@end