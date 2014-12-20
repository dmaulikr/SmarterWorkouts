#import <Foundation/Foundation.h>

@class Workout;

@protocol WorkoutSelectionDelegate <NSObject>

- (void)workoutSelected:(Workout *)workout;
@end