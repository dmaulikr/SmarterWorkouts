#import <Foundation/Foundation.h>

@class Workout;

@protocol EditWorkoutDelegate <NSObject>

- (void)editWorkout:(Workout *)workout;
@end