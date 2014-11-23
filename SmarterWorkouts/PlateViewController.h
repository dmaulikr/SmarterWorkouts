#import <UIKit/UIKit.h>
#import "ContextViewController.h"

@interface PlateViewController : ContextViewController

@property(weak, nonatomic) IBOutlet UILabel *moreLabel;
@property(nonatomic) BOOL expanded;
@property (weak, nonatomic) IBOutlet UILabel *plates;

- (void)setWeight:(NSDecimalNumber *)weight;

@end