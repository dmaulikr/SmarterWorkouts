#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "BarPlateSetup.h"
#import "Bar.h"
#import "LbsKgMenuItem.h"

@implementation BarPlateSetup

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUnits:@"lbs"];
}

- (void)setUnits:(NSString *)units {
    _units = [units mutableCopy];
    [self setBarFieldFromUnits];
    [self updateLbsKgSelector];
}

- (void)setBarFieldFromUnits {
    Bar *bar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", self.units]];
    [self.barTextField setText:[bar.weight stringValue]];
}

- (void)updateLbsKgSelector {
    LbsKgMenuItem *item = [[NSBundle mainBundle] loadNibNamed:@"LbsKgMenuItem" owner:self options:nil][0];
    [item setDelegate:self];
    [item setSelectedUnits:self.units];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
}

- (void)unitsChanged:(NSString *)selectedUnits {
    self.units = selectedUnits;
    [self setBarFieldFromUnits];
}

@end