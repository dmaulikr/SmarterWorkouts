#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UnitsChangedDelegate;

@interface LbsKgMenuItem : UIView {
}
@property(weak, nonatomic) IBOutlet UILabel *lbsLabel;
@property(weak, nonatomic) IBOutlet UILabel *kgLabel;
@property(nonatomic, copy) NSString *selectedUnits;

@property(weak, nonatomic) NSObject <UnitsChangedDelegate> *delegate;
@end