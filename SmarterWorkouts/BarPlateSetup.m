#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "BarPlateSetup.h"
#import "Bar.h"
#import "LbsKgMenuItem.h"
#import "Plate.h"
#import "CellRegister.h"
#import "PlateCell.h"

@implementation BarPlateSetup

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUnits:@"lbs"];
    [self.platesTable setDelegate:self];
    [self.platesTable setDataSource:self];
    self.platesTable.rowHeight = UITableViewAutomaticDimension;

    [CellRegister registerClass:PlateCell.class for:self.platesTable];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self plates] count];
}

- (NSArray *)plates {
    NSArray *plates = [Plate MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", self.units]];
    return [plates sortedArrayUsingComparator:^NSComparisonResult(Plate *p1, Plate *p2) {
        return [p2.weight compare:p1.weight];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PlateCell.class)];
    [cell setPlate:[self plates][(NSUInteger) indexPath.row]];
    [cell setDelegate:self];
    return cell;
}

- (void)plateBeganEditing:(Plate *)p {
    float index = [[self plates] indexOfObject:p];
    UITableViewCell *cell = [self.platesTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger) index inSection:0]];
    CGFloat cellHeight = cell.frame.size.height;
    [self.platesTable setContentOffset:CGPointMake(0, index * cellHeight) animated:YES];
}

@end