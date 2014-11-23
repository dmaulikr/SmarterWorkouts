#import <Foundation/Foundation.h>

@class Activity;

@protocol ActivitySelectorDelegate <NSObject>
- (void)activitySelected:(Activity *)activity;
@end