#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "BarPlateSetup.h"
#import "Bar.h"
#import "LbsKgMenuItem.h"

@implementation BarPlateSetup

- (void)viewDidLoad {
    [super viewDidLoad];
    self.units = @"lbs";
    [self setBarFieldFromUnits];
    [self updateLbsKgSelector];
}

- (void)setBarFieldFromUnits {
    Bar *bar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", self.units]];
    [self.barTextField setText:[bar.weight stringValue]];
}

- (void)updateLbsKgSelector {
    LbsKgMenuItem *item = [[NSBundle mainBundle] loadNibNamed:@"LbsKgMenuItem" owner:self options:nil][0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self action:nil];
}

@end