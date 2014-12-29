#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;
@class NSManagedObjectContext;

@interface CurrentWorkout : NSObject

+ (CurrentWorkout *)instance;

@property(nonatomic, strong) Workout *workout;

@property(nonatomic, strong) NSManagedObjectContext *context;
@end