#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnitsChangedDelegate.h"
#import "PlateCellProtocol.h"

@interface BarPlateSetup : UIViewController <UnitsChangedDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PlateCellProtocol> {
}
@property(weak, nonatomic) IBOutlet UITextField *barTextField;

@property(weak, nonatomic) IBOutlet UITableView *platesTable;

@property(nonatomic, copy) NSString *units;
@end