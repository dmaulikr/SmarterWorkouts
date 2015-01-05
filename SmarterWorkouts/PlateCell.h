#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlavorTextUITextField;
@class Plate;
@protocol PlateCellProtocol;

@interface PlateCell : UITableViewCell <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *platesField;

@property(nonatomic, strong) Plate *plate;
@property(nonatomic, weak) NSObject<PlateCellProtocol> *delegate;

@end