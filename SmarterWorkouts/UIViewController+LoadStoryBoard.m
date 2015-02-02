#import "UIViewController+LoadStoryBoard.h"

@implementation UIViewController (LoadStoryBoard)

- (void)loadStoryboard:(NSString *)nibName {
    UIStoryboard *historyStoryboard = [UIStoryboard storyboardWithName:nibName bundle:[NSBundle mainBundle]];
    UIViewController *controller = [historyStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end