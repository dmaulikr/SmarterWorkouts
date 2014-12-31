#import <Foundation/Foundation.h>

@protocol WorkoutControlsDelegate <NSObject>

- (void)toggleOrdering:(BOOL)ordering;

@end