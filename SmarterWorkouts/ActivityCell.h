#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ActivityFormDelegate;
@class Set;
@class Activity;

@interface ActivityCell : UITableViewCell

@property(nonatomic, weak) NSObject <ActivityFormDelegate> *activityFormDelegate;
@property(nonatomic, strong) Activity *activity;
@property(nonatomic, strong) Set *selectedSet;

@end