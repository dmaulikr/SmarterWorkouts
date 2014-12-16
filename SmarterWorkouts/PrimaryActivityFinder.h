#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Workout;

@interface PrimaryActivityFinder : NSObject

+ (NSString *)primaryActivityFor: (Workout *) workout;
@end