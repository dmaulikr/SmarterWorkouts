#import "DurationDisplay.h"

@implementation DurationDisplay

+ (NSString *)displayHumanDurationFromSeconds:(NSNumber *)seconds {
    const int SECONDS_PER_HOUR = 3600;
    const int SECONDS_PER_MINUTE = 60;

    NSString *displayString = @"";

    int secondsInt = [seconds intValue];
    int hours = secondsInt / SECONDS_PER_HOUR;
    if (hours > 0) {
        displayString = [NSString stringWithFormat:@"%d hrs", hours];
        secondsInt %= SECONDS_PER_HOUR;
    }

    int minutes = secondsInt / SECONDS_PER_MINUTE;
    if (minutes > 0) {
        displayString = [NSString stringWithFormat:@"%@%@%d mins", displayString,
                                                   [displayString length] > 0 ? @" " : @"", minutes];
        secondsInt %= SECONDS_PER_MINUTE;
    }

    if (secondsInt > 0) {
        displayString = [NSString stringWithFormat:@"%@%@%d secs", displayString,
                                                   [displayString length] > 0 ? @" " : @"", secondsInt];
    }
    return displayString;
}

@end