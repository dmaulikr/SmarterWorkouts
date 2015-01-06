#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "BarPlateSetup.h"
#import "Bar.h"
#import "LbsKgMenuItem.h"
#import "Plate.h"
#import "CellRegister.h"
#import "PlateCell.h"
#import "FlavorTextUITextField.h"
#import "DecimalNumbers.h"
#import "InputAccessoryBuilder.h"

@implementation BarPlateSetup

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUnits:@"lbs"];
    [self.platesTable setDelegate:self];
    [self.platesTable setDataSource:self];
    self.platesTable.rowHeight = UITableViewAutomaticDimension;
    [self.barTextField setDelegate:self];
    [InputAccessoryBuilder saveButton:self.barTextField];

    [CellRegister registerClass:PlateCell.class for:self.platesTable];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

    self.lbsKgMenuItem = [[NSBundle mainBundle] loadNibNamed:@"LbsKgMenuItem" owner:self options:nil][0];
    [self.lbsKgMenuItem setDelegate:self];
    [self.lbsKgMenuItem setSelectedUnits:self.units];
    self.navigationItem.rightBarButtonItems = @[
            [[UIBarButtonItem alloc] initWithCustomView:self.lbsKgMenuItem]
    ];

    self.plates = [self findPlates];
};

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)viewTapped {
    [self.view endEditing:YES];
}

- (void)setUnits:(NSString *)units {
    _units = [units mutableCopy];
    [self setBarFieldFromUnits];
    [self updateLbsKgSelector];
    [self.barTextField setFlavor:units];
    [self.barTextField removeFlavor];
    [self.barTextField addFlavor];
}

- (void)setBarFieldFromUnits {
    Bar *bar = [self findBar];
    [self.barTextField setText:[bar.weight stringValue]];
}

- (Bar *)findBar {
    Bar *bar = [Bar MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"units", self.units]];
    return bar;
}

- (void)updateLbsKgSelector {
    [self.lbsKgMenuItem setSelectedUnits:self.units];
}

- (void)unitsChanged:(NSString *)selectedUnits {
    self.units = selectedUnits;
    [self setBarFieldFromUnits];

    self.plates = [self findPlates];
    [self.platesTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self plates] count];
}

- (NSArray *)findPlates {
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [(FlavorTextUITextField *) textField removeFlavor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.barTextField text]];
    Bar *bar = [self findBar];
    bar.weight = weight;

    [(FlavorTextUITextField *) textField addFlavor];
}

- (void)plateBeganEditing:(Plate *)p {
    float index = [[self plates] indexOfObject:p];
    UITableViewCell *cell = [self.platesTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger) index inSection:0]];
    CGFloat cellHeight = cell.frame.size.height;
    [self.platesTable setContentOffset:CGPointMake(0, index * cellHeight) animated:YES];
}

- (void)plateEndEditing:(Plate *)plate {
}

@end