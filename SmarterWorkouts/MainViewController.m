#import "MainViewController.h"
#import "UIImage+ColorFromImage.h"
#import "UIImageViewHelper.h"

@implementation MainViewController {
    __weak IBOutlet UIImageView *historyImage;
    __weak IBOutlet UIImageView *workoutImage;
    __weak IBOutlet UIImageView *friendsImage;
    __weak IBOutlet UILabel *friendsLabel;
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

    [self.friendsButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (66 / 255.0)
                                                                                   green:(CGFloat) (33 / 255.0)
                                                                                    blue:(CGFloat) (99 / 255.0)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];
    [UIImageViewHelper makeWhite:historyImage];
    [UIImageViewHelper makeWhite:workoutImage];
    [UIImageViewHelper makeWhite:friendsImage];

    [friendsLabel.superview bringSubviewToFront:friendsLabel];
    [friendsImage.superview bringSubviewToFront:friendsImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title = @"Home";
}

- (IBAction)selectHistory:(id)sender {
    [self loadStoryboard:@"HistoryViewController"];
}

- (IBAction)selectWorkout:(id)sender {
    [self loadStoryboard:@"Workout"];
}

- (IBAction)selectFriends:(id)sender {
}

- (void)loadStoryboard:(NSString *)nibName {
    UIStoryboard *historyStoryboard = [UIStoryboard storyboardWithName:nibName bundle:[NSBundle mainBundle]];
    UIViewController *controller = [historyStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end