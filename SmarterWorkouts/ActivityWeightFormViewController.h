#import <UIKit/UIKit.h>

@interface ActivityWeightFormViewController : UIViewController
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *weightInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *repsInput;
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *setsInput;
@property(nonatomic, strong) id form;

- (void)attachBelow:(UIView *)field inView:(UIView *)view;
@end