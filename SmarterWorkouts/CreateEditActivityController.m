#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "WeightCreateViewController.h"
#import "Activity.h"
#import "CreateEditActivityController.h"

const int WEIGHT_INDEX = 1;

@implementation CreateEditActivityController {
    __weak IBOutlet UITextField *activityNameField;
    __weak IBOutlet UISegmentedControl *typeSegment;
}

- (IBAction)typeChanged:(id)sender {
    [self.weightController setActive:[sender selectedSegmentIndex] == WEIGHT_INDEX];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.activityToEdit ? @"Edit" : @"Create";
    [self.weightController setupInitialActivity:self.activityToEdit];
    [activityNameField setText:[self.activityToEdit name]];

    if (self.activityToEdit) {
        NSDictionary *segments = @{@"weight" : @1, @"timer" : @2};
        NSNumber *segment = segments[self.activityToEdit.type];
        if (segment) {
            [typeSegment setSelectedSegmentIndex:[segment integerValue]];
        }
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem setEnabled:self.activityToEdit != nil];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (void)save {
    Activity *activity = [Activity MR_createEntity];
    activity.name = [activityNameField text];
    activity.type = @"miscellaneous";
    if ([self.weightController active]) {
        [self.weightController addExtraInfo:activity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([[segue destinationViewController] class] == WeightCreateViewController.class) {
        self.weightController = [segue destinationViewController];
    }
}

- (IBAction)activityNameChanged:(id)sender {
    [self.navigationItem.rightBarButtonItem setEnabled:[[sender text] length] > 0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [activityNameField becomeFirstResponder];
}

@end