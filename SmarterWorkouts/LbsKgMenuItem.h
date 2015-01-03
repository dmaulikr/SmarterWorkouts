#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LbsKgMenuItem : UIView {}
@property (weak, nonatomic) IBOutlet UILabel *lbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *kgLabel;
@property(nonatomic, copy) NSString *selectedUnits;
@end