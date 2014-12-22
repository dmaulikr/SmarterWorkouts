#import "MainViewController.h"

@implementation MainViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title = @"Home";
}

- (IBAction)selectHistory:(id)sender {
}

- (IBAction)selectWorkout:(id)sender {
    UIStoryboard *workoutStoryboard = [UIStoryboard storyboardWithName:@"Workout" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [workoutStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)selectFriends:(id)sender {
}

@end