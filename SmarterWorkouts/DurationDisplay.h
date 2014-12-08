#import <Foundation/Foundation.h>

@interface DurationDisplay : NSObject

+ (NSString *)displayHumanDurationFromSeconds: (NSNumber *)minutes;

+ (NSString *)displayTimerFromSeconds:(NSNumber *)seconds;

@end