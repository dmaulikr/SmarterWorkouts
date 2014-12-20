#import <Foundation/Foundation.h>

@class Activity;
@class Workout;

@protocol ActivitySelectorDelegate
- (void)activitySelected:(Activity *)activity;

- (void)copyWorkout:(Workout *)workout;
@end