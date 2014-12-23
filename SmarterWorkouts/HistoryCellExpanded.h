#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HistoryCell.h"

@protocol EditWorkoutDelegate;

@interface HistoryCellExpanded : HistoryCell {}
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *editButtonLabel;
@property(weak, nonatomic) NSObject<EditWorkoutDelegate> *delegate;

@end