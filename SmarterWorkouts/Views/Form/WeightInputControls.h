#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ActivityWeightFormCell;

@interface WeightInputControls : NSObject
+ (void)addLbsKgSelector:(UITextField *)field delegate:(ActivityWeightFormCell *)delegate;
@end