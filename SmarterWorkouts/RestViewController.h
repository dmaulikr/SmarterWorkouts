#import "ContextViewController.h"

@interface RestViewController : ContextViewController {}
@property (weak, nonatomic) IBOutlet UILabel *timeRemaining;
@property (weak, nonatomic) IBOutlet UIButton *stopTimer;
@property (weak, nonatomic) IBOutlet UIButton *startTimer;
@property (weak, nonatomic) IBOutlet UIButton *justLog;

@end