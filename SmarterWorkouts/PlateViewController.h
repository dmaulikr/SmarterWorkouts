#import <UIKit/UIKit.h>
#import "ContextViewController.h"

@interface PlateViewController : ContextViewController

@property(weak, nonatomic) IBOutlet UILabel *moreLabel;
@property(nonatomic) BOOL expanded;

@end