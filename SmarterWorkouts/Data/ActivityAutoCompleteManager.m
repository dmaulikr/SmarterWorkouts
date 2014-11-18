#import "ActivityAutoCompleteManager.h"

@implementation ActivityAutoCompleteManager

static ActivityAutoCompleteManager *instance;

+ (ActivityAutoCompleteManager *)instance {
    @synchronized (self) {
        if (!instance) {
            instance = [self new];
        }
    }
    return instance;
}

- (NSString *)textField:(HTAutocompleteTextField *)textField completionForPrefix:(NSString *)prefix ignoreCase:(BOOL)ignoreCase {
    NSString *activity = @"Squat";
    if([activity containsString:prefix]){
        return [activity substringFromIndex:prefix.length];
    }
    return @"";
}


@end