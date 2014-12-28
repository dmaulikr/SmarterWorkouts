#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface CurrentWorkout : NSObject

+ (CurrentWorkout *)instance;

@property(nonatomic, strong) Workout *workout;

@end