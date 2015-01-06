#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlavorTextUITextField;
@class Plate;
@protocol PlateCellProtocol;

@interface PlateCell : UITableViewCell <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *platesField;
@property (weak, nonatomic) IBOutlet FlavorTextUITextField *weightField;

@property(nonatomic, strong) Plate *plate;
@property(nonatomic, weak) NSObject<PlateCellProtocol> *delegate;

@end