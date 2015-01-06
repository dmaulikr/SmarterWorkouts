#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnitsChangedDelegate.h"
#import "PlateCellProtocol.h"

@class LbsKgMenuItem;
@class FlavorTextUITextField;

@interface BarPlateSetup : UIViewController <UnitsChangedDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PlateCellProtocol> {
}
@property(weak, nonatomic) IBOutlet FlavorTextUITextField *barTextField;

@property(weak, nonatomic) IBOutlet UITableView *platesTable;

@property(nonatomic, copy) NSString *units;
@property(nonatomic, strong) LbsKgMenuItem *lbsKgMenuItem;
@property(nonatomic, strong) NSArray *plates;
@end