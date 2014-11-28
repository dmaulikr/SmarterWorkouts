#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Set;

@interface SetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@property(nonatomic, strong) Set *set;
@end