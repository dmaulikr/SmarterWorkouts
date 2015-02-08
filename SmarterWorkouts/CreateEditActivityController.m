#import <MagicalRecord/MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "WeightActivityEditViewController.h"
#import "Activity.h"
#import "CreateEditActivityController.h"
#import "TimeActivityEditViewController.h"

const int WEIGHT_INDEX = 1;
const int TIMER_INDEX = 2;

@implementation CreateEditActivityController {
    __weak IBOutlet UITextField *activityNameField;
    __weak IBOutlet UISegmentedControl *typeSegment;
    __weak IBOutlet UIView *weightContainer;
    __weak IBOutlet UIView *timeContainer;
}

- (IBAction)typeChanged:(id)sender {
    [self showHideEditContainers:sender];
}

- (void)showHideEditContainers:(id)sender {
    [weightContainer setHidden:[typeSegment selectedSegmentIndex] != WEIGHT_INDEX];
    [timeContainer setHidden:[typeSegment selectedSegmentIndex] != TIMER_INDEX];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.activityToEdit ? @"Edit" : @"Create";
    [self.weightController setupInitialActivity:self.activityToEdit];
    [self.timerController setupInitialActivity:self.activityToEdit];
    [activityNameField setText:[self.activityToEdit name]];

    if (self.activityToEdit) {
        NSDictionary *segments = @{@"weight" : @1, @"timer" : @2};
        NSNumber *segment = segments[self.activityToEdit.type];
        if (segment) {
            [typeSegment setSelectedSegmentIndex:[segment integerValue]];
            [self showHideEditContainers:nil];
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
    Activity *activity = nil;
    if (!self.activityToEdit) {
        activity = [Activity MR_createEntity];
    }
    else {
        activity = self.activityToEdit;
    }

    activity.name = [activityNameField text];
    activity.type = @"miscellaneous";
    if (![weightContainer isHidden]) {
        [self.weightController addExtraInfo:activity];
    }
    if (![timeContainer isHidden]) {
        [self.timerController addExtraInfo:activity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([[segue destinationViewController] class] == WeightActivityEditViewController.class) {
        self.weightController = [segue destinationViewController];
    }
    else if ([[segue destinationViewController] class] == TimeActivityEditViewController.class) {
        self.timerController = [segue destinationViewController];
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