#import <Foundation/Foundation.h>

@interface DurationDisplay : NSObject

+ (NSString *)displayHumanDurationFromSeconds: (NSNumber *)minutes;

@end