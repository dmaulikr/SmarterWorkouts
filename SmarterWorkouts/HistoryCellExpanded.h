#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HistoryCell.h"

@protocol EditWorkoutDelegate;
@class Workout;
@class AllSetsDataSource;

@interface HistoryCellExpanded : HistoryCell {
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allSetsTableViewHeight;
@property(weak, nonatomic) IBOutlet UITextField *dateField;
@property(weak, nonatomic) IBOutlet UIButton *editButton;
@property(weak, nonatomic) IBOutlet UILabel *editButtonLabel;
@property(weak, nonatomic) NSObject <EditWorkoutDelegate> *delegate;
@property(weak, nonatomic) IBOutlet UITableView *allSetsTableView;

@property(nonatomic, strong) AllSetsDataSource *allSetsDataSource;
@end