#import <objc/objc-api.h>
#import <CoreData/CoreData.h>
#import "CurrentWorkout.h"
#import "Workout.h"

@implementation CurrentWorkout

+ (CurrentWorkout *)instance {
    static CurrentWorkout *currentWorkout = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentWorkout = [[self alloc] init];
    });
    return currentWorkout;
}

@end