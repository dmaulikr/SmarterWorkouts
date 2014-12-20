#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface WorkoutCopier : NSObject

+ (void)copy:(Workout *)src to:(Workout *)dest;
@end