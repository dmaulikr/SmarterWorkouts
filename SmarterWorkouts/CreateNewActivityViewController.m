#import "CreateNewActivityViewController.h"
#import "ActivityCreateController.h"
#import "WeightCreateViewController.h"


const int WEIGHT_INDEX = 1;

@implementation CreateNewActivityViewController {
    __weak IBOutlet UITextField *activityNameField;
    __weak IBOutlet UISegmentedControl *typeSegment;
    __weak IBOutlet UIView *weightContainerView;
}

- (IBAction)typeChanged:(id)sender {
    [weightContainerView setHidden:[sender selectedSegmentIndex] != WEIGHT_INDEX];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create";
    [weightContainerView setHidden:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)viewTapped {
    [self.view endEditing:NO];
}

- (void)save {
    if (![weightContainerView isHidden]) {
        NSDictionary *additionalData = [self.weightController activityData];
        NSLog(@"%@", additionalData);
    }
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