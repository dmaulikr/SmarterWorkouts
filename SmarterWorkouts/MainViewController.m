#import "MainViewController.h"
#import "UIImage+ColorFromImage.h"
#import "HistoryViewController.h"

@implementation MainViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.workoutButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (68 / 255.0)
                                                                                   green:(CGFloat) (108 / 255.0)
                                                                                    blue:(CGFloat) (179.0 / 255)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];

    [self.historyButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (63 / 255.0)
                                                                                   green:(CGFloat) (195 / 255.0)
                                                                                    blue:(CGFloat) (128.0 / 255)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title = @"Home";
}

- (IBAction)selectHistory:(id)sender {
    [self loadStoryboard: @"HistoryViewController"];
}

- (IBAction)selectWorkout:(id)sender {
    [self loadStoryboard:@"Workout"];
}

- (IBAction)selectFriends:(id)sender {
}

- (void)loadStoryboard: (NSString *)nibName {
    UIStoryboard *historyStoryboard = [UIStoryboard storyboardWithName:nibName bundle:[NSBundle mainBundle]];
    UIViewController *controller = [historyStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end