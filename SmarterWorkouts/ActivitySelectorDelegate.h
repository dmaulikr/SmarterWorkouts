#import <Foundation/Foundation.h>

@class Activity;

@protocol ActivitySelectorDelegate
- (void)activitySelected:(Activity *)activity;
@end